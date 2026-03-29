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
          "max-w-[85%] px-5 py-3 rounded-2xl text-sm leading-relaxed shadow-sm",
          isAssistant
            ? "bg-gray-100 dark:bg-gray-800 text-gray-900 dark:text-white rounded-bl-sm border border-gray-200/50 dark:border-gray-700/50"
            : "bg-gradient-to-r from-cyan-500 to-violet-600 text-white rounded-br-sm"
        )}
      >
        <p className="whitespace-pre-wrap">{message.content}</p>
        <span className={cn(
          "text-[10px] mt-1.5 block",
          isAssistant ? "text-gray-500 dark:text-gray-400" : "text-white/70"
        )}>
          {new Date(message.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
        </span>
      </div>
    </motion.div>
  );
};

