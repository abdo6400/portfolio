import React from 'react';
import { motion, AnimatePresence } from 'motion/react';
import { ChatButton } from '../atoms/ChatButton';
import { ChatInput } from '../atoms/ChatInput';
import { ChatHeader } from '../molecules/ChatHeader';
import { MessageList } from '../molecules/MessageList';
import { useAI } from '../../hooks/useAI';

export const ChatAssistant: React.FC = () => {
  const { messages, isLoading, isOpen, toggleChat, sendMessage, clearChat } = useAI();

  return (
    <>
      <ChatButton isOpen={isOpen} onClick={toggleChat} />

      <AnimatePresence>
        {isOpen && (
          <motion.div
            initial={{ opacity: 0, scale: 0.9, translateY: 20, transformOrigin: 'bottom right' }}
            animate={{ opacity: 1, scale: 1, translateY: 0 }}
            exit={{ opacity: 0, scale: 0.9, translateY: 20 }}
            className="fixed bottom-24 right-6 w-[90vw] md:w-[420px] h-[600px] max-h-[80vh] flex flex-col bg-white/95 dark:bg-gray-950/95 backdrop-blur-xl border border-gray-200/50 dark:border-gray-800/50 rounded-3xl shadow-2xl z-40 overflow-hidden"
          >
            <ChatHeader onClose={toggleChat} onClear={clearChat} />
            <MessageList messages={messages} isLoading={isLoading} />
            <ChatInput onSend={sendMessage} isLoading={isLoading} />
          </motion.div>
        )}
      </AnimatePresence>
    </>
  );
};
