import { useState, useEffect } from 'react';
import { Eye } from 'lucide-react';
import { motion } from 'motion/react';

const COUNTER_API_BASE = 'https://api.counterapi.dev/v2/abdelrahman-amrs-team-3524/first-counter-3524';

export function ProfileViews() {
    const [viewCount, setViewCount] = useState<number>(0);
    const [isLoading, setIsLoading] = useState(true);

    useEffect(() => {
        const trackView = async () => {
            try {
                const apiKey = import.meta.env.VITE_COUNTER_API_KEY || 'ut_w5EsE8891lgtGu5HLKvROCezTBTHO6YtVkVsH55W';

                if (!apiKey) {
                    console.warn('Counter API key not found, using localStorage fallback');
                    fallbackToLocalStorage();
                    return;
                }

                // Increment the counter
                const response = await fetch(`${COUNTER_API_BASE}/up`, {
                    method: 'GET',
                    headers: {
                        'Authorization': `Bearer ${apiKey}`
                    }
                });

                if (!response.ok) {
                    throw new Error(`HTTP error! status: ${response.status}`);
                }

                const data = await response.json();
                setViewCount(data.value || data.count || 0);
                setIsLoading(false);
            } catch (error) {
                console.error('Error tracking page view:', error);
                fallbackToLocalStorage();
            }
        };

        const fallbackToLocalStorage = () => {
            const storedCount = localStorage.getItem('profileViewCount');
            const currentCount = storedCount ? parseInt(storedCount, 10) : 0;
            const newCount = currentCount + 1;
            localStorage.setItem('profileViewCount', newCount.toString());
            setViewCount(newCount);
            setIsLoading(false);
        };

        // Wait a bit for the page to load
        const timer = setTimeout(trackView, 100);
        return () => clearTimeout(timer);
    }, []);

    return (
        <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 1.4, duration: 0.6 }}
            className="fixed bottom-6 left-6 z-50"
        >
            <div className="glass-card px-5 py-3 rounded-2xl shadow-xl border border-cyan-200/30 dark:border-cyan-700/30 flex items-center gap-3 hover:scale-105 transition-transform">
                <div className="w-10 h-10 bg-gradient-to-br from-cyan-500 to-violet-500 rounded-xl flex items-center justify-center shadow-lg">
                    <Eye className="text-white" size={20} />
                </div>
                <div>
                    <div className="text-2xl font-black text-gradient">
                        {isLoading ? '...' : viewCount}
                    </div>
                    <div className="text-xs text-gray-600 dark:text-gray-400 font-semibold">Profile Views</div>
                </div>
            </div>
        </motion.div>
    );
}
