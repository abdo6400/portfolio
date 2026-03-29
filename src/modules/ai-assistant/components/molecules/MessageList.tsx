import React, { useRef, useEffect } from 'react';
import { MessageBubble } from '../atoms/MessageBubble';
import { Message } from '../../types';
import { Loader2 } from 'lucide-react';

interface MessageListProps {
  messages: Message[];
  isLoading: boolean;
}

export const MessageList: React.FC<MessageListProps> = ({ messages, isLoading }) => {
  const scrollRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (scrollRef.current) {
      scrollRef.current.scrollTop = scrollRef.current.scrollHeight;
    }
  }, [messages, isLoading]);

  return (
    <div
      ref={scrollRef}
      className="flex-grow overflow-y-auto p-5 custom-scrollbar scroll-smooth"
      style={{ maxHeight: 'calc(100% - 140px)' }}
    >
      <div className="flex flex-col min-h-full">
        {messages.map((msg) => (
          <MessageBubble key={msg.id} message={msg} />
        ))}
        {isLoading && (
          <div className="flex justify-start mb-4">
            <div className="bg-gray-100 dark:bg-gray-800 text-gray-900 dark:text-white px-5 py-3 rounded-2xl rounded-bl-sm border border-gray-200/50 dark:border-gray-700/50 flex items-center gap-2.5 shadow-sm">
              <Loader2 size={16} className="animate-spin text-cyan-500" />
              <span className="text-sm font-medium">Typing...</span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
