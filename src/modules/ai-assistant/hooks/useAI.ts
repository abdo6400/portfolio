import { useState, useCallback } from 'react';
import { Message, ChatState } from '../types';
import { AIService } from '../services/AIService';

const GREETING: Message = {
  id: 'greeting',
  role: 'assistant',
  content: "Hello! 👋 I'm **your AI assistant**, your digital guide to Abdulrahman's portfolio. I can detail his projects, tech stack, or professional journey. How can I assist you today?",
  timestamp: Date.now(),
};

export function useAI() {
  const [state, setState] = useState<ChatState>({
    messages: [GREETING],
    isLoading: false,
    isOpen: false,
  });

  const toggleChat = useCallback(() => {
    setState(prev => ({ ...prev, isOpen: !prev.isOpen }));
  }, []);

  const sendMessage = useCallback(async (content: string) => {
    if (!content.trim()) return;

    const userMessage: Message = {
      id: Date.now().toString(),
      role: 'user',
      content,
      timestamp: Date.now(),
    };

    setState(prev => ({
      ...prev,
      messages: [...prev.messages, userMessage],
      isLoading: true,
    }));

    try {
      // API requires starting with a user message, so we filter out the initial assistant greeting
      const conversationHistory = [...state.messages, userMessage].filter(msg => msg.id !== 'greeting');
      const response = await AIService.sendMessage(conversationHistory);

      const assistantMessage: Message = {
        id: (Date.now() + 1).toString(),
        role: 'assistant',
        content: response,
        timestamp: Date.now(),
      };

      setState(prev => ({
        ...prev,
        messages: [...prev.messages, assistantMessage],
        isLoading: false,
      }));
    } catch (error) {
      console.error('Failed to send AI message:', error);
      setState(prev => ({ ...prev, isLoading: false }));
    }
  }, [state.messages]);

  const clearChat = useCallback(() => {
    setState(prev => ({
      ...prev,
      messages: [GREETING],
    }));
  }, []);

  return {
    ...state,
    toggleChat,
    sendMessage,
    clearChat,
  };
}
