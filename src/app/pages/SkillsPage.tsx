import { Smartphone, Server, Wrench, Palette, Star, TrendingUp, Award } from 'lucide-react';
import { motion } from 'motion/react';
import skillsData from '../../imports/skills.json';

export function SkillsPage() {
    const iconMap: Record<string, any> = {
        mobile: Smartphone,
        server: Server,
        tools: Wrench,
        flutter: Palette,
    };

    const colorMap: Record<string, string> = {
        mobile: 'from-blue-500 to-cyan-500',
        server: 'from-purple-500 to-pink-500',
        tools: 'from-orange-500 to-red-500',
        flutter: 'from-green-500 to-emerald-500',
    };

    return (
        <div className="min-h-screen py-24 bg-white dark:bg-gray-950 relative overflow-hidden">
            {/* Decorative Background Elements */}
            <div className="absolute top-1/2 -right-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>
            <div className="absolute top-1/4 -left-20 w-80 h-80 bg-purple-500/5 rounded-full blur-[100px]"></div>
            <div className="absolute bottom-1/4 right-1/3 w-60 h-60 bg-indigo-500/5 rounded-full blur-[80px]"></div>

            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.7 }}
                    className="text-center mb-20"
                >
                    <h1 className="text-5xl sm:text-7xl font-black mb-6 text-gray-900 dark:text-white tracking-tight">
                        <span className="text-gradient">Skills & Expertise</span>
                    </h1>
                    <div className="w-32 h-2 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full shadow-lg mb-8"></div>
                    <p className="text-xl text-gray-600 dark:text-gray-400 max-w-3xl mx-auto leading-relaxed">
                        A comprehensive toolkit of technologies and frameworks I've mastered over the years to build exceptional mobile applications.
                    </p>
                </motion.div>

                {/* Skills Grid */}
                <div className="grid md:grid-cols-2 gap-10 mb-20">
                    {skillsData.map((category, idx) => {
                        const Icon = iconMap[category.icon] || Server;
                        const color = colorMap[category.icon] || 'from-blue-500 to-cyan-500';
                        return (
                            <motion.div
                                key={idx}
                                initial={{ opacity: 0, y: 40 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.2 + idx * 0.15, duration: 0.7 }}
                                className="glass-card hover-lift rounded-[2.5rem] p-10 border-white/40 dark:border-gray-800/50 group"
                            >
                                <div className="flex items-center gap-5 mb-8">
                                    <div className={`w-16 h-16 bg-gradient-to-br ${color} rounded-[1.25rem] flex items-center justify-center shadow-lg group-hover:scale-110 transition-transform duration-300`}>
                                        <Icon className="text-white" size={32} />
                                    </div>
                                    <div>
                                        <h3 className="text-3xl font-bold text-gray-900 dark:text-white">
                                            {category.category}
                                        </h3>
                                        <p className="text-gray-500 dark:text-gray-400 text-sm mt-1">
                                            {category.skills.length} skills
                                        </p>
                                    </div>
                                </div>

                                <div className="flex flex-wrap gap-3">
                                    {category.skills.map((skill, skillIdx) => (
                                        <motion.span
                                            key={skillIdx}
                                            initial={{ opacity: 0, scale: 0.8 }}
                                            animate={{ opacity: 1, scale: 1 }}
                                            transition={{ delay: 0.4 + skillIdx * 0.05, duration: 0.4 }}
                                            className="px-5 py-2.5 glass-card rounded-2xl text-gray-700 dark:text-gray-300 font-semibold text-sm hover:bg-blue-600 hover:text-white dark:hover:bg-blue-500 transition-all cursor-default shadow-sm border-white/50 hover:scale-105"
                                        >
                                            {skill.name}
                                        </motion.span>
                                    ))}
                                </div>
                            </motion.div>
                        );
                    })}
                </div>

                {/* Expertise Level Section */}
                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.8, duration: 0.7 }}
                    className="glass-card p-12 rounded-[3rem] border-white/40 dark:border-gray-800/50 mb-16"
                >
                    <h2 className="text-3xl font-bold text-gray-900 dark:text-white mb-10 text-center">Expertise Level</h2>
                    <div className="grid md:grid-cols-3 gap-8">
                        {[
                            { level: 'Expert', icon: Star, skills: ['Flutter', 'Dart', 'BLoC', 'Clean Architecture'], color: 'from-yellow-500 to-orange-500' },
                            { level: 'Advanced', icon: TrendingUp, skills: ['Firebase', 'REST APIs', 'State Management', 'CI/CD'], color: 'from-blue-500 to-cyan-500' },
                            { level: 'Proficient', icon: Award, skills: ['Node.js', 'Python', 'UI/UX Design', 'Testing'], color: 'from-purple-500 to-pink-500' },
                        ].map((item, index) => {
                            const Icon = item.icon;
                            return (
                                <motion.div
                                    key={index}
                                    initial={{ opacity: 0, y: 30 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 1 + index * 0.15, duration: 0.6 }}
                                    className="text-center p-8 rounded-2xl bg-white/50 dark:bg-gray-800/50 hover:scale-105 transition-transform"
                                >
                                    <div className={`w-16 h-16 bg-gradient-to-br ${item.color} rounded-2xl flex items-center justify-center mx-auto mb-6 shadow-lg`}>
                                        <Icon className="text-white" size={28} />
                                    </div>
                                    <h4 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">{item.level}</h4>
                                    <div className="flex flex-wrap justify-center gap-2">
                                        {item.skills.map((skill, idx) => (
                                            <span key={idx} className="px-3 py-1.5 bg-gray-100 dark:bg-gray-700 rounded-lg text-sm text-gray-700 dark:text-gray-300 font-medium">
                                                {skill}
                                            </span>
                                        ))}
                                    </div>
                                </motion.div>
                            );
                        })}
                    </div>
                </motion.div>

                {/* Stats */}
                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 1.2, duration: 0.7 }}
                    className="grid grid-cols-2 md:grid-cols-4 gap-6"
                >
                    {[
                        { label: 'Technologies', value: '15+' },
                        { label: 'Frameworks', value: '8+' },
                        { label: 'Tools', value: '12+' },
                        { label: 'Platforms', value: '3+' },
                    ].map((stat, index) => (
                        <motion.div
                            key={stat.label}
                            initial={{ opacity: 0, y: 30 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 1.3 + index * 0.1, duration: 0.6 }}
                            className="glass-card p-6 rounded-2xl text-center hover:scale-105 transition-transform"
                        >
                            <div className="text-3xl sm:text-4xl font-black text-gradient mb-2">{stat.value}</div>
                            <div className="text-sm text-gray-600 dark:text-gray-400 font-medium">{stat.label}</div>
                        </motion.div>
                    ))}
                </motion.div>
            </div>
        </div>
    );
}
