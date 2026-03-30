import { useState, useEffect } from 'react';
import { Eye } from 'lucide-react';
import { motion } from 'motion/react';

export function ProfileViews() {
    const [viewCount, setViewCount] = useState<number>(0);

    useEffect(() => {
        // Try to use a global counter service
        const fetchViewCount = async () => {
            try {
                // Use visitorbadge.io - a reliable global counter service
                const response = await fetch('https://api.visitorbadge.io/api/visitors?path=abdulrahman-portfolio&label=Profile%20Views&style=flat');
                const data = await response.json();
                if (data && data.value) {
                    setViewCount(data.value);
                } else {
                    throw new Error('Invalid response');
                }
            } catch (error) {
                console.error('Error fetching view count:', error);
                // Fallback to localStorage
                const storedCount = localStorage.getItem('profileViewCount');
                const currentCount = storedCount ? parseInt(storedCount, 10) : 0;
                const newCount = currentCount + 1;
                localStorage.setItem('profileViewCount', newCount.toString());
                setViewCount(newCount);
            }
        };

        fetchViewCount();
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
