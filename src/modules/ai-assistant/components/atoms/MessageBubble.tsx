import React from 'react';
import { motion } from 'motion/react';
import ReactMarkdown from 'react-markdown';
import remarkGfm from 'remark-gfm';
import { Orbit } from 'lucide-react';
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
        "flex w-full mb-6 items-start gap-2.5",
        isAssistant ? "flex-row" : "flex-row-reverse"
      )}
    >
      {isAssistant && (
        <div className="flex-shrink-0 mt-1">
          <div className="w-8 h-8 rounded-full bg-gradient-to-br from-cyan-500 to-violet-600 flex items-center justify-center shadow-lg shadow-cyan-500/20 ring-2 ring-white/10 overflow-hidden relative group">
            <Orbit className="w-5 h-5 text-white animate-[spin_4s_linear_infinite]" />
            <div className="absolute inset-0 bg-white/20 opacity-0 group-hover:opacity-100 transition-opacity"></div>
          </div>
        </div>
      )}

      <div
        className={cn(
          "max-w-[85%] md:max-w-[80%] px-5 py-3.5 rounded-2xl text-sm leading-relaxed shadow-sm transition-all",
          isAssistant
            ? "bg-white/80 dark:bg-gray-900/80 backdrop-blur-md text-gray-900 dark:text-gray-100 rounded-tl-sm border border-gray-200/60 dark:border-gray-800/60 hover:border-cyan-500/30"
            : "bg-gradient-to-br from-cyan-600 to-violet-700 text-white rounded-tr-sm shadow-md shadow-cyan-500/10"
        )}
      >
        <div className={cn(
          "prose prose-sm max-w-none transition-all",
          isAssistant ? "dark:prose-invert" : "prose-invert",
          "prose-strong:font-black prose-strong:text-cyan-600 dark:prose-strong:text-cyan-400",
          "prose-p:leading-relaxed prose-pre:bg-black/10 dark:prose-pre:bg-white/5 prose-pre:rounded-lg prose-code:text-cyan-600 dark:prose-code:text-cyan-400 prose-code:bg-cyan-500/10 prose-code:px-1 prose-code:rounded prose-code:before:content-none prose-code:after:content-none",
          "prose-table:border-collapse prose-th:border prose-th:border-gray-200/50 dark:prose-th:border-gray-700/50 prose-th:px-3 prose-th:py-2 prose-td:border prose-td:border-gray-200/50 dark:prose-td:border-gray-700/50 prose-td:px-3 prose-td:py-2"
        )}>
          <ReactMarkdown remarkPlugins={[remarkGfm]}>
            {message.content}
          </ReactMarkdown>
        </div>
        <div className="flex items-center justify-between mt-2.5">
           <span className={cn(
            "text-[9px] font-bold uppercase tracking-widest opacity-40",
            isAssistant ? "text-gray-500" : "text-white"
          )}>
            {isAssistant ? "Antigravity OS" : "User Interaction"}
          </span>
          <span className={cn(
            "text-[10px] font-medium opacity-60",
            isAssistant ? "text-gray-500" : "text-white"
          )}>
            {new Date(message.timestamp).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
          </span>
        </div>
      </div>
    </motion.div>
  );
};

