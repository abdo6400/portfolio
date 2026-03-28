/// <reference types="vite/client" />
import profile from '../../../imports/profile.json';
import projects from '../../../imports/projects.json';
import experienceData from '../../../imports/experience.json';
import skillsData from '../../../imports/skills.json';
import { Message } from '../types';

const GEMINI_API_KEY = import.meta.env.VITE_GEMINI_API_KEY;
const GEMINI_API_URL = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent';

export class AIService {
  private static getSystemPrompt(): string {
    const projectSummary = projects.map((p: any) => `- ${p.title}: ${p.description} (Tech: ${p.technologies.join(', ')})`).join('\n');
    const experienceSummary = experienceData.experience.map((e: any) => `- ${e.title} at ${e.company} (${e.startDate} - ${e.endDate}): ${e.description}`).join('\n');
    const skillsSummary = skillsData.map((cat: any) => `- ${cat.category}: ${cat.skills.map((s: any) => s.name).join(', ')}`).join('\n');

    return `
You are a helpful AI assistant for ${profile.name}'s professional portfolio. 
Your goal is to answer questions about ${profile.name} (also known as "me" or "the developer") accurately and professionally.

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
2. If you don't know the answer based on the provided context, politely say so and suggest contacting ${profile.name} directly via email.
3. Don't mention that you are an AI model unless asked. Act as a digital concierge for this portfolio.
4. If asked about a project, provide its title and a brief highlight from its description.
`;
  }

  static async sendMessage(messages: Message[]): Promise<string> {
    if (!GEMINI_API_KEY) {
      console.error('Gemini API Key is missing. Check your .env file.');
      return "I'm sorry, but the AI Assistant is not configured yet. Please add a valid Gemini API key to the environment variables.";
    }

    const systemPrompt = this.getSystemPrompt();
    
    // Format messages for Gemini API
    const contents = messages.map(msg => ({
      role: msg.role === 'assistant' ? 'model' : 'user',
      parts: [{ text: msg.content }]
    }));

    try {
      const response = await fetch(`${GEMINI_API_URL}?key=${GEMINI_API_KEY}`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({ 
          contents,
          system_instruction: {
            parts: [{ text: systemPrompt }]
          }
        }),
      });

      if (!response.ok) {
        const errorData = await response.json().catch(() => ({}));
        console.error('Gemini API Error Response:', errorData);
        throw new Error(`API error: ${response.status} ${response.statusText}`);
      }

      const data = await response.json();
      
      if (!data.candidates || data.candidates.length === 0) {
        console.error('Gemini API returned no candidates:', data);
        return "I'm sorry, I couldn't generate a response. Please try again.";
      }

      return data.candidates[0].content.parts[0].text;
    } catch (error) {
      console.error('AI Service Error:', error);
      return "I'm having trouble connecting right now. Please try again later or reach out to me via the contact form!";
    }
  }
}
