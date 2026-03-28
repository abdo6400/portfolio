/// <reference types="vite/client" />
import profile from '../../../imports/profile.json';
import projects from '../../../imports/projects.json';
import experienceData from '../../../imports/experience.json';
import skillsData from '../../../imports/skills.json';
import { Message } from '../types';

const GEMINI_API_KEY = import.meta.env.VITE_GEMINI_API_KEY;
const PRIMARY_MODEL = 'gemini-3-flash-preview';
const FALLBACK_MODEL = 'gemini-1.5-flash';
const BASE_URL = 'https://generativelanguage.googleapis.com/v1beta/models';

export class AIService {
  private static getSystemPrompt(): string {
    const projectSummary = projects.map((p: any) => `- ${p.title}: ${p.description} (Tech: ${p.technologies.join(', ')})`).join('\n');
    const experienceSummary = experienceData.experience.map((e: any) => `- ${e.title} at ${e.company} (${e.startDate} - ${e.endDate}): ${e.description}`).join('\n');
    const skillsSummary = skillsData.map((cat: any) => `- ${cat.category}: ${cat.skills.map((s: any) => s.name).join(', ')}`).join('\n');

    return `
You are a helpful AI assistant for ${profile.name}'s professional portfolio. 
Context about ${profile.name}:
- Title: ${profile.title}
- Bio: ${profile.bio}
- Location: ${profile.location}
- Contact: ${profile.email} | ${profile.phone}
- Social: GitHub (${profile.socialLinks.github}), LinkedIn (${profile.socialLinks.linkedin})

Projects:
${projectSummary}

Experience:
${experienceSummary}

Skills:
${skillsSummary}

Guidelines:
1. Be professional, friendly, and concise.
2. Answer based ON THE ABOVE CONTEXT about ${profile.name}.
3. Don't mention that you are an AI model unless asked.
`;
  }

  static async sendMessage(messages: Message[]): Promise<string> {
    if (!GEMINI_API_KEY) {
      return "I'm sorry, but the AI Assistant is not configured yet. Please add a valid Gemini API key to the environment variables.";
    }

    const systemPrompt = this.getSystemPrompt();
    
    // Format messages for Gemini API
    const contents = [
      {
        role: 'user',
        parts: [{ text: `INSTRUCTIONS: ${systemPrompt}\n\nUSER QUESTION: ${messages[0].content}` }]
      },
      ...messages.slice(1).map(msg => ({
        role: msg.role === 'assistant' ? 'model' : 'user',
        parts: [{ text: msg.content }]
      }))
    ];

    try {
      // Attempt 1: Primary Model
      return await this.fetchWithRetry(PRIMARY_MODEL, contents);
    } catch (error: any) {
      console.warn(`Primary model (${PRIMARY_MODEL}) failed. Error: ${error.message}. Attempting fallback...`);
      
      try {
        // Attempt 2: Fallback Model
        return await this.fetchWithRetry(FALLBACK_MODEL, contents);
      } catch (fallbackError) {
        console.error('All AI models failed:', fallbackError);
        return "I'm having trouble connecting right now. Please try again later or reach out to me via the contact form!";
      }
    }
  }

  private static async fetchWithRetry(model: string, contents: any[], retries = 2, delay = 1000): Promise<string> {
    const url = `${BASE_URL}/${model}:generateContent`;

    for (let i = 0; i <= retries; i++) {
      try {
        const response = await fetch(url, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
            'x-goog-api-key': GEMINI_API_KEY,
          },
          body: JSON.stringify({ contents }),
        });

        if (response.status === 503 || response.status === 429) {
          // If overloaded or rate limited, retry after delay
          if (i < retries) {
            console.log(`Retrying ${model} after ${delay}ms... (Attempt ${i + 1}/${retries})`);
            await new Promise(resolve => setTimeout(resolve, delay));
            delay *= 2; // Exponential backoff
            continue;
          }
        }

        if (!response.ok) {
          const errorData = await response.json().catch(() => ({}));
          throw new Error(`API error: ${response.status} ${response.statusText} ${JSON.stringify(errorData)}`);
        }

        const data = await response.json();
        return data.candidates[0].content.parts[0].text;
      } catch (error) {
        if (i === retries) throw error;
      }
    }
    throw new Error('Retries exhausted');
  }
}
