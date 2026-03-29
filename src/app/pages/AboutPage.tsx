import { Code2, Award, Users, Zap, Heart, Target, Rocket } from 'lucide-react';
import { motion } from 'motion/react';
import profileData from '../../imports/profile.json';
import experienceData from '../../imports/experience.json';
import projectsData from '../../imports/projects.json';

export function AboutPage() {
    const yearsOfExperience = profileData.bio.match(/\d+\+?\s+years/i)?.[0] || '4+ Years';
    const publishedAppsCount = projectsData.filter(p => p.store || p.appStore).length;
    const appsCount = `${publishedAppsCount}+ Apps`;
    const companies = experienceData.experience.map(exp => exp.company).join(', ');

    const highlights = [
        {
            icon: Code2,
            title: yearsOfExperience,
            description: 'Flutter Development Experience',
            color: 'from-blue-500 to-cyan-500',
        },
        {
            icon: Award,
            title: appsCount,
            description: 'Published on App Store and Play Store',
            color: 'from-purple-500 to-pink-500',
        },
        {
            icon: Users,
            title: 'Multiple Companies',
            description: companies,
            color: 'from-orange-500 to-red-500',
        },
        {
            icon: Zap,
            title: 'Expert in',
            description: 'BLoC & Clean Architecture',
            color: 'from-green-500 to-emerald-500',
        },
    ];

    const values = [
        {
            icon: Heart,
            title: 'Passion',
            description: 'I love what I do and it shows in every line of code I write.',
        },
        {
            icon: Target,
            title: 'Precision',
            description: 'Attention to detail and commitment to delivering pixel-perfect UIs.',
        },
        {
            icon: Rocket,
            title: 'Innovation',
            description: 'Always exploring new technologies and best practices.',
        },
    ];

    return (
        <div className="min-h-screen py-24 bg-gray-50 dark:bg-gray-900 relative overflow-hidden">
            {/* Decorative Background Elements */}
            <div className="absolute top-1/2 -left-20 w-80 h-80 bg-blue-500/5 rounded-full blur-[100px]"></div>
            <div className="absolute top-1/4 -right-20 w-80 h-80 bg-purple-500/5 rounded-full blur-[100px]"></div>
            <div className="absolute bottom-1/4 left-1/3 w-60 h-60 bg-indigo-500/5 rounded-full blur-[80px]"></div>

            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.7 }}
                    className="text-center mb-20"
                >
                    <h1 className="text-5xl sm:text-7xl font-black mb-6 text-gray-900 dark:text-white tracking-tight">
                        <span className="text-gradient">About Me</span>
                    </h1>
                    <div className="w-32 h-2 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full shadow-lg"></div>
                </motion.div>

                {/* Main Content */}
                <div className="grid lg:grid-cols-2 gap-16 items-start mb-24">
                    {/* Bio */}
                    <motion.div
                        initial={{ opacity: 0, x: -50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.2, duration: 0.7 }}
                        className="space-y-8"
                    >
                        <div className="glass-card p-10 rounded-[2.5rem] border-white/40 dark:border-gray-800/50">
                            <h2 className="text-3xl font-bold text-gray-900 dark:text-white mb-6">Who I Am</h2>
                            <p className="text-xl text-gray-700 dark:text-gray-300 leading-relaxed font-medium mb-6">
                                {profileData.bio}
                            </p>
                            <p className="text-lg text-gray-600 dark:text-gray-400 leading-relaxed mb-6">
                                I'm passionate about creating scalable mobile solutions that solve real-world problems.
                                My expertise spans across various domains including E-commerce, AI integration, Real Estate,
                                and Financial applications.
                            </p>
                            <div className="inline-flex items-center gap-2 px-5 py-3 bg-blue-50 dark:bg-blue-900/20 text-blue-600 dark:text-blue-400 rounded-2xl font-bold text-sm border border-blue-100 dark:border-blue-800">
                                <Zap size={18} />
                                <span>Available for new opportunities</span>
                            </div>
                        </div>

                        {/* Values */}
                        <div className="glass-card p-10 rounded-[2.5rem] border-white/40 dark:border-gray-800/50">
                            <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-8">My Values</h3>
                            <div className="space-y-6">
                                {values.map((value, index) => {
                                    const Icon = value.icon;
                                    return (
                                        <motion.div
                                            key={index}
                                            initial={{ opacity: 0, x: -20 }}
                                            animate={{ opacity: 1, x: 0 }}
                                            transition={{ delay: 0.4 + index * 0.1, duration: 0.5 }}
                                            className="flex items-start gap-5"
                                        >
                                            <div className="w-12 h-12 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-xl flex items-center justify-center flex-shrink-0 shadow-lg">
                                                <Icon className="text-white" size={22} />
                                            </div>
                                            <div>
                                                <h4 className="text-lg font-bold text-gray-900 dark:text-white mb-1">{value.title}</h4>
                                                <p className="text-gray-600 dark:text-gray-400">{value.description}</p>
                                            </div>
                                        </motion.div>
                                    );
                                })}
                            </div>
                        </div>
                    </motion.div>

                    {/* Highlights Grid */}
                    <motion.div
                        initial={{ opacity: 0, x: 50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.3, duration: 0.7 }}
                        className="grid sm:grid-cols-2 gap-6"
                    >
                        {highlights.map((highlight, index) => {
                            const Icon = highlight.icon;
                            return (
                                <motion.div
                                    key={index}
                                    initial={{ opacity: 0, y: 30 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.4 + index * 0.1, duration: 0.6 }}
                                    className="glass-card hover-lift rounded-[2rem] p-8 border-white/40 dark:border-gray-800/50 group"
                                >
                                    <div className={`w-16 h-16 bg-gradient-to-br ${highlight.color} rounded-2xl flex items-center justify-center mb-6 shadow-lg group-hover:scale-110 transition-transform duration-300`}>
                                        <Icon className="text-white" size={30} />
                                    </div>
                                    <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-3">
                                        {highlight.title}
                                    </h3>
                                    <p className="text-gray-600 dark:text-gray-400 leading-relaxed">{highlight.description}</p>
                                </motion.div>
                            );
                        })}
                    </motion.div>
                </div>

                {/* Journey Section */}
                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.6, duration: 0.7 }}
                    className="glass-card p-12 rounded-[3rem] border-white/40 dark:border-gray-800/50"
                >
                    <h2 className="text-3xl font-bold text-gray-900 dark:text-white mb-8 text-center">My Journey</h2>
                    <div className="grid md:grid-cols-3 gap-8">
                        {[
                            { year: '2020', title: 'Started Flutter', desc: 'Began my journey with Flutter development' },
                            { year: '2022', title: 'First Published App', desc: 'Published my first app on Play Store' },
                            { year: '2026', title: 'Senior Developer', desc: 'Became a Senior Flutter Developer' },
                        ].map((milestone, index) => (
                            <motion.div
                                key={index}
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 0.8 + index * 0.15, duration: 0.5 }}
                                className="text-center p-6 rounded-2xl bg-white/50 dark:bg-gray-800/50 hover:scale-105 transition-transform"
                            >
                                <div className="text-4xl font-black text-gradient mb-3">{milestone.year}</div>
                                <h4 className="text-xl font-bold text-gray-900 dark:text-white mb-2">{milestone.title}</h4>
                                <p className="text-gray-600 dark:text-gray-400">{milestone.desc}</p>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            </div>
        </div>
    );
}
