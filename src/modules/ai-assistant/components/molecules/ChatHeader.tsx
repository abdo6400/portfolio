import React from 'react';
import { Sparkles, X, RotateCcw } from 'lucide-react';
import profile from '../../../../imports/profile.json';
import profileImage from 'figma:asset/197868cc9149d5b4b12480e05e963f942645a274.png';

interface ChatHeaderProps {
  onClose: () => void;
  onClear: () => void;
}

export const ChatHeader: React.FC<ChatHeaderProps> = ({ onClose, onClear }) => {
  return (
    <div className="flex items-center justify-between p-5 border-b border-gray-200/50 dark:border-gray-800/50 bg-white/80 dark:bg-gray-950/80 backdrop-blur-xl rounded-t-3xl">
      <div className="flex items-center gap-3">
        <div className="relative">
          <img
            src={profileImage}
            alt={profile.name}
            className="w-11 h-11 rounded-xl border-2 border-cyan-500/30 object-cover shadow-sm shadow-cyan-900/10"
          />
          <div className="absolute -bottom-0.5 -right-0.5 w-3.5 h-3.5 bg-emerald-500 rounded-full border-2 border-white dark:border-gray-950 ring-2 ring-emerald-500/30 animate-pulse" />
        </div>
        <div className="flex flex-col">
          <h3 className="text-sm font-bold text-gray-900 dark:text-white flex items-center gap-1.5 leading-tight">
            AI Assistant <Sparkles size={14} className="text-cyan-500" />
          </h3>
          <span className="text-[11px] text-gray-500 dark:text-gray-400 font-medium">Online • Powered by Groq</span>
        </div>
      </div>
      <div className="flex items-center gap-1">
        <button
          onClick={onClear}
          title="Clear Chat"
          className="p-2.5 text-gray-400 hover:text-cyan-500 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl transition-all duration-200"
        >
          <RotateCcw size={18} />
        </button>
        <button
          onClick={onClose}
          title="Close Chat"
          className="p-2.5 text-gray-400 hover:text-red-500 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-xl transition-all duration-200"
        >
          <X size={20} />
        </button>
      </div>
    </div>
  );
};
