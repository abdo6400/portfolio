import React from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { Bot, X } from 'lucide-react';
import { cn } from '../../utils/cn';

interface ChatButtonProps {
  isOpen: boolean;
  onClick: () => void;
}

export const ChatButton: React.FC<ChatButtonProps> = ({ isOpen, onClick }) => {
  return (
    <motion.button
      initial={{ scale: 0, opacity: 0 }}
      animate={{ scale: 1, opacity: 1 }}
      whileHover={{ scale: 1.1 }}
      whileTap={{ scale: 0.9 }}
      onClick={onClick}
      className={cn(
        "fixed bottom-6 right-6 w-14 h-14 rounded-full flex items-center justify-center shadow-2xl transition-colors duration-300 z-50",
        isOpen ? "bg-red-500 text-white" : "bg-cyan-600 text-white"
      )}
      aria-label="Toggle AI Assistant"
    >
      <AnimatePresence mode="wait">
        {isOpen ? (
          <motion.div
            key="close"
            initial={{ rotate: -90, opacity: 0 }}
            animate={{ rotate: 0, opacity: 1 }}
            exit={{ rotate: 90, opacity: 0 }}
            transition={{ duration: 0.2 }}
          >
            <X size={28} />
          </motion.div>
        ) : (
          <motion.div
            key="bot"
            initial={{ rotate: 90, opacity: 0 }}
            animate={{ rotate: 0, opacity: 1 }}
            exit={{ rotate: -90, opacity: 0 }}
            transition={{ duration: 0.2 }}
          >
            <Bot size={28} />
          </motion.div>
        )}
      </AnimatePresence>
    </motion.button>
  );
};
