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
        "fixed bottom-6 right-6 w-16 h-16 rounded-2xl flex items-center justify-center shadow-2xl transition-all duration-300 z-[45]",
        isOpen
          ? "bg-gradient-to-br from-red-500 to-rose-600 text-white shadow-red-500/30"
          : "bg-gradient-to-br from-cyan-500 to-violet-600 text-white shadow-cyan-500/30 hover:shadow-cyan-500/50"
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
