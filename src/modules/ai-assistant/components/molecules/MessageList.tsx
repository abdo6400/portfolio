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
      className="flex-grow overflow-y-auto p-4 custom-scrollbar scroll-smooth"
      style={{ maxHeight: 'calc(100% - 130px)' }}
    >
      <div className="flex flex-col min-h-full">
        {messages.map((msg) => (
          <MessageBubble key={msg.id} message={msg} />
        ))}
        {isLoading && (
          <div className="flex justify-start mb-4">
            <div className="bg-slate-800 text-slate-100 px-4 py-2 rounded-2xl rounded-bl-sm border border-slate-700 flex items-center gap-2">
              <Loader2 size={14} className="animate-spin text-cyan-400" />
              <span className="text-xs">Typing...</span>
            </div>
          </div>
        )}
      </div>
    </div>
  );
};
