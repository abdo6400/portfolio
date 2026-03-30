import React from 'react';
import { motion } from 'motion/react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { cn } from '../../utils/cn';
import { Message } from '../../types';

interface MessageBubbleProps {
  message: Message;
}

export const MessageBubble: React.FC<MessageBubbleProps> = ({ message }) => {
  const isAssistant = message.role === 'assistant';

  return (
    <motion.div
      initial={{ scale: 0.95, opacity: 0, translateY: 10 }}
      animate={{ scale: 1, opacity: 1, translateY: 0 }}
      transition={{ duration: 0.3 }}
      className={cn(
        "flex w-full mb-4",
        isAssistant ? "justify-start" : "justify-end"
      )}
    >
      <div
        className={cn(
          "max-w-[90%] md:max-w-[85%] px-5 py-3.5 rounded-2xl text-sm leading-relaxed shadow-sm",
          isAssistant
            ? "bg-white dark:bg-gray-900 text-gray-900 dark:text-gray-100 rounded-bl-sm border border-gray-200/60 dark:border-gray-800/60"
            : "bg-gradient-to-br from-cyan-600 to-violet-700 text-white rounded-br-sm shadow-md shadow-cyan-500/10"
        )}
      >
        <div className={cn(
          "prose prose-sm max-w-none transition-all",
          isAssistant ? "dark:prose-invert" : "prose-invert",
          "prose-p:leading-relaxed prose-pre:bg-black/10 dark:prose-pre:bg-white/5 prose-pre:rounded-lg prose-code:text-cyan-600 dark:prose-code:text-cyan-400 prose-code:bg-cyan-500/10 prose-code:px-1 prose-code:rounded prose-code:before:content-none prose-code:after:content-none"
        )}>
          <ReactMarkdown remarkPlugins={[remarkGfm]}>
            {message.content}
          </ReactMarkdown>
        </div>
        <span className={cn(
          "text-[10px] mt-2 block font-medium opacity-60",
          isAssistant ? "text-gray-500" : "text-white"
        )}>
          {new Date(message.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
        </span>
      </div>
    </motion.div>
  );
};

