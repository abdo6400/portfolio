import React, { useState, useRef, KeyboardEvent } from 'react';
import { Send, Loader2 } from 'lucide-react';
import { cn } from '../../utils/cn';

interface ChatInputProps {
  onSend: (message: string) => void;
  isLoading: boolean;
}

export const ChatInput: React.FC<ChatInputProps> = ({ onSend, isLoading }) => {
  const [value, setValue] = useState('');
  const inputRef = useRef<HTMLInputElement>(null);

  const handleSend = () => {
    if (!value.trim() || isLoading) return;
    onSend(value);
    setValue('');
    inputRef.current?.focus();
  };

  const handleKeyDown = (e: KeyboardEvent<HTMLInputElement>) => {
    if (e.key === 'Enter') {
      handleSend();
    }
  };

  return (
    <div className="p-4 border-t border-slate-700 bg-slate-900/50 backdrop-blur-md rounded-b-3xl">
      <div className="relative flex items-center gap-2">
        <input
          ref={inputRef}
          type="text"
          value={value}
          onChange={(e) => setValue(e.target.value)}
          onKeyDown={handleKeyDown}
          placeholder="Type your message..."
          disabled={isLoading}
          className={cn(
            "flex-grow bg-slate-800 text-slate-100 rounded-full px-5 py-3 pr-12 focus:outline-none focus:ring-2 focus:ring-cyan-500/50 transition-all text-sm",
            isLoading && "opacity-50 cursor-not-allowed"
          )}
        />
        <button
          onClick={handleSend}
          disabled={!value.trim() || isLoading}
          className={cn(
            "absolute right-2 p-2 rounded-full transition-all duration-300",
            !value.trim() || isLoading 
              ? "text-slate-500 bg-transparent" 
              : "text-white bg-cyan-600 hover:bg-cyan-500 shadow-lg shadow-cyan-900/20"
          )}
        >
          {isLoading ? <Loader2 size={18} className="animate-spin" /> : <Send size={18} />}
        </button>
      </div>
    </div>
  );
};
