/// <reference types="vite/client" />
import profile from '../../../imports/profile.json';
import projects from '../../../imports/projects.json';
import experienceData from '../../../imports/experience.json';
import skillsData from '../../../imports/skills.json';
import { Message } from '../types';

const GROQ_API_KEY = import.meta.env.VITE_GROQ_API_KEY || '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';
const API_URL = import.meta.env.VITE_AI_API_URL || 'https://api.groq.com/openai/v1/chat/completions';
const MODEL = import.meta.env.VITE_AI_MODEL || 'llama-3.3-70b-versatile';

/** HTTP status codes that are permanent failures — never worth retrying. */
const PERMANENT_ERRORS = new Set([400, 401, 403, 404]);

export class AIService {
  private static getSystemPrompt(): string {
    const projectSummary = projects
      .map((p: any) => `### ${p.title} (${p.category})
- **Description**: ${p.description}
- **Tech Stack**: ${p.technologies.join(', ')}
- **Features**: ${p.features ? p.features.join('; ') : 'N/A'}`)
      .join('\n\n');

    const experienceSummary = experienceData.experience
      .map((e: any) => `- **${e.title}** at **${e.company}** (${e.startDate} - ${e.endDate})
  - ${e.description}`)
      .join('\n');

    const skillsSummary = skillsData
      .map((cat: any) => `- **${cat.category}**: ${cat.skills.map((s: any) => s.name).join(', ')}`)
      .join('\n');

    return `
You are "Antigravity", the official high-end AI assistant for ${profile.name}'s professional portfolio. 
Your goal is to provide specific, detailed, and professional insights about ${profile.name}'s work, experience, and technical capabilities.

### PERSONALITY:
- **Professional & Enthusiastic**: You represent a top-tier developer.
- **Concise but Informative**: Avoid unnecessary fluff; get straight to the technical gems.
- **Helpful & Proactive**: If asked about a skill, mention a project where it was used.

### CONTEXT ABOUT ${profile.name}:
- **Current Role**: ${profile.title}
- **Bio**: ${profile.bio}
- **Location**: ${profile.location}
- **Contact**: ${profile.email} (Forward users here for business inquiries)
- **Links**: GitHub (${profile.socialLinks.github}), LinkedIn (${profile.socialLinks.linkedin})

### PROJECTS:
${projectSummary}

### PROFESSIONAL EXPERIENCE:
${experienceSummary}

### TECHNICAL SKILLS:
${skillsSummary}

### GUIDELINES FOR REPLIES:
1. **Use Markdown**: Essential for readability. Use **bold**, *italics*, lists, and tables.
2. **Code Blocks**: If explaining a technical concept or showing an example snippet from ${profile.name}'s domain (.NET 8, Flutter, React), use \`\`\`language code blocks.
3. **Be Specific**: If someone asks "What did he do?", don't just say "He did mobile apps". Mention "He built **ADDUSTOUR**, a high-performance news app with 5-star ratings on Google Play."
4. **Call to Action**: If the user seems interested in a project, encourage them to check the GitHub link or contact ${profile.name}.
5. **No Hallucinations**: Only answer based on the provided context.
`;
  }

  static async sendMessage(messages: Message[]): Promise<string> {
    if (!GROQ_API_KEY && !import.meta.env.VITE_AI_API_URL) {
      return "I'm sorry, but the AI Assistant is not configured yet. Please add a valid Groq API key to the environment variables.";
    }

    const systemPrompt = this.getSystemPrompt();

    // Format messages for OpenAI-style API
    const promptMessages = [
      { role: 'system', content: systemPrompt },
      ...messages.map(msg => ({
        role: msg.role,
        content: msg.content,
      }))
    ];

    try {
      return await this.fetchWithRetry(promptMessages);
    } catch (err: any) {
      console.error(`AI API failed: ${err.message}`);
      return "I'm having trouble connecting right now. Please try again in a moment, or reach out via the contact form!";
    }
  }

  /**
   * Attempt the request up to (1 + retries) times.
   */
  private static async fetchWithRetry(
    messages: any[],
    retries = 2,
    baseDelay = 1500,
  ): Promise<string> {
    let delay = baseDelay;

    for (let attempt = 0; attempt <= retries; attempt++) {
      try {
        const response = await fetch(API_URL, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'Authorization': `Bearer ${GROQ_API_KEY}`,
          },
          body: JSON.stringify({
            model: MODEL,
            messages: messages,
            temperature: 1,
            max_completion_tokens: 8192,
            top_p: 1,
            reasoning_effort: 'medium',
          }),
        });

        if (response.ok) {
          const data = await response.json();
          return data.choices?.[0]?.message?.content || "I couldn't generate a response. Please try again.";
        }

        // Permanent error: abort immediately
        if (PERMANENT_ERRORS.has(response.status)) {
          const errorData = await response.json().catch(() => ({}));
          throw new Error(`Permanent API error ${response.status}: ${JSON.stringify(errorData)}`);
        }

        // Transient error (429 / 503 / 500): retry with exponential backoff
        if (attempt < retries) {
          const waitMs = delay;
          console.log(`AI API rate-limited or error (${response.status}). Retrying in ${waitMs}ms… (attempt ${attempt + 1}/${retries})`);
          await new Promise(resolve => setTimeout(resolve, waitMs));
          delay = Math.min(delay * 2, 8000); // exponential backoff, max 8 s
          continue;
        }

        // Exhausted retries
        const errorData = await response.json().catch(() => ({}));
        throw new Error(`API error ${response.status} after ${retries} retries: ${JSON.stringify(errorData)}`);
      } catch (err: any) {
        if (PERMANENT_ERRORS.has(err.status) || attempt === retries) {
          throw err;
        }
        console.warn(`Attempt ${attempt + 1} failed, retrying...`, err);
        await new Promise(resolve => setTimeout(resolve, delay));
        delay = Math.min(delay * 2, 8000);
      }
    }

    throw new Error('Retries exhausted');
  }
}
