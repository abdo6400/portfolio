import React from 'react';
import { motion } from 'motion/react';
import { cn } from '../../utils/cn';
import { Message } from '../../types';

interface MessageBubbleProps {
  message: Message;
}

export const MessageBubble: React.FC<MessageBubbleProps> = ({ message }) => {
  const isAssistant = message.role === 'assistant';

  return (
    <motion.div
      initial={{ scale: 0, opacity: 0, translateY: 20 }}
      animate={{ scale: 1, opacity: 1, translateY: 0 }}
      transition={{ duration: 0.3 }}
      className={cn(
        "flex w-full mb-4",
        isAssistant ? "justify-start" : "justify-end"
      )}
    >
      <div
        className={cn(
          "max-w-[85%] px-4 py-2 rounded-2xl text-sm leading-relaxed",
          isAssistant 
            ? "bg-slate-800 text-slate-100 rounded-bl-sm border border-slate-700" 
            : "bg-cyan-600 text-white rounded-br-sm"
        )}
      >
        <p className="whitespace-pre-wrap">{message.content}</p>
        <span className="text-[10px] opacity-70 mt-1 block">
          {new Date(message.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
        </span>
      </div>
    </motion.div>
  );
};
