import { useState, useEffect } from 'react';
import { Eye } from 'lucide-react';
import { motion } from 'motion/react';

declare global {
    interface Window {
        Counter: any;
    }
}

export function ProfileViews() {
    const [viewCount, setViewCount] = useState<number>(0);

    useEffect(() => {
        // Use CounterAPI to track views from all visitors
        const trackView = () => {
            try {
                // Check if Counter is available
                if (typeof window.Counter !== 'undefined') {
                    const counter = new window.Counter({ workspace: 'abdulrahman-portfolio' });
                    counter.up('profile-views')
                        .then((result: any) => {
                            setViewCount(result.value);
                        })
                        .catch((error: any) => {
                            console.error('Error tracking page view:', error);
                            // Fallback to localStorage
                            fallbackToLocalStorage();
                        });
                } else {
                    // Counter not loaded yet, fallback to localStorage
                    fallbackToLocalStorage();
                }
            } catch (error) {
                console.error('Error initializing Counter:', error);
                fallbackToLocalStorage();
            }
        };

        const fallbackToLocalStorage = () => {
            const storedCount = localStorage.getItem('profileViewCount');
            const currentCount = storedCount ? parseInt(storedCount, 10) : 0;
            const newCount = currentCount + 1;
            localStorage.setItem('profileViewCount', newCount.toString());
            setViewCount(newCount);
        };

        // Wait a bit for the Counter script to load
        const timer = setTimeout(trackView, 100);
        return () => clearTimeout(timer);
    }, []);

    return (
        <motion.div
            initial={{ opacity: 0, y: 20 }}
            animate={{ opacity: 1, y: 0 }}
            transition={{ delay: 1.4, duration: 0.6 }}
            className="fixed bottom-6 right-6 z-50"
        >
            <div className="glass-card px-5 py-3 rounded-2xl shadow-xl border border-cyan-200/30 dark:border-cyan-700/30 flex items-center gap-3 hover:scale-105 transition-transform">
                <div className="w-10 h-10 bg-gradient-to-br from-cyan-500 to-violet-500 rounded-xl flex items-center justify-center shadow-lg">
                    <Eye className="text-white" size={20} />
                </div>
                <div>
                    <div className="text-2xl font-black text-gradient">{viewCount}</div>
                    <div className="text-xs text-gray-600 dark:text-gray-400 font-semibold">Profile Views</div>
                </div>
            </div>
        </motion.div>
    );
}
