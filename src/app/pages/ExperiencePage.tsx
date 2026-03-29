import { Briefcase, GraduationCap, MapPin, Calendar, Award, BookOpen } from 'lucide-react';
import { motion } from 'motion/react';
import experienceData from '../../imports/experience.json';

export function ExperiencePage() {
    return (
        <div className="min-h-screen py-24 bg-gray-50 dark:bg-gray-900 relative overflow-hidden">
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
                        <span className="text-gradient">Experience & Education</span>
                    </h1>
                    <div className="w-32 h-2 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto rounded-full shadow-lg mb-8"></div>
                    <p className="text-xl text-gray-600 dark:text-gray-400 max-w-3xl mx-auto leading-relaxed">
                        My professional journey and academic background that have shaped my expertise in mobile development.
                    </p>
                </motion.div>

                <div className="grid lg:grid-cols-2 gap-16">
                    {/* Work Experience */}
                    <motion.div
                        initial={{ opacity: 0, x: -50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.2, duration: 0.7 }}
                        className="space-y-10"
                    >
                        <div className="flex items-center gap-4 mb-10">
                            <div className="w-16 h-16 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-2xl flex items-center justify-center shadow-lg">
                                <Briefcase className="text-white" size={30} />
                            </div>
                            <div>
                                <h2 className="text-3xl font-bold text-gray-900 dark:text-white">Work Experience</h2>
                                <p className="text-gray-500 dark:text-gray-400 text-sm mt-1">{experienceData.experience.length} positions</p>
                            </div>
                        </div>

                        <div className="space-y-12">
                            {experienceData.experience.map((exp, index) => (
                                <motion.div
                                    key={exp.id}
                                    initial={{ opacity: 0, y: 30 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.3 + index * 0.15, duration: 0.6 }}
                                    className="relative pl-10 pb-1 border-l-2 border-blue-500/20 dark:border-blue-900/50 last:border-l-0 last:pb-0"
                                >
                                    <div className="absolute -left-2.5 top-0 w-5 h-5 bg-gradient-to-r from-blue-600 to-indigo-600 rounded-full shadow-xl ring-4 ring-white dark:ring-gray-900"></div>

                                    <div className="glass-card hover-lift p-8 rounded-[2rem] border-white/40 dark:border-gray-800/50 group">
                                        <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-2 group-hover:text-blue-600 dark:group-hover:text-blue-400 transition-colors">
                                            {exp.title}
                                        </h3>
                                        <div className="text-lg font-bold text-blue-600 dark:text-blue-400 mb-4 px-4 py-1.5 bg-blue-500/5 dark:bg-blue-400/5 rounded-lg inline-block">
                                            {exp.company}
                                        </div>

                                        <div className="flex flex-wrap gap-4 text-sm font-semibold text-gray-500 dark:text-gray-400 mb-6">
                                            <div className="flex items-center gap-2">
                                                <MapPin size={16} className="text-blue-500" />
                                                <span>{exp.location}</span>
                                            </div>
                                            <div className="flex items-center gap-2 text-indigo-500">
                                                <Calendar size={16} />
                                                <span>{exp.startDate} - {exp.endDate}</span>
                                            </div>
                                        </div>

                                        <p className="text-gray-600 dark:text-gray-400 mb-6 leading-relaxed">{exp.description}</p>

                                        <ul className="space-y-3">
                                            {exp.highlights.map((highlight, idx) => (
                                                <li key={idx} className="flex items-start gap-3 text-sm text-gray-600 dark:text-gray-400">
                                                    <span className="flex-shrink-0 w-2 h-2 rounded-full bg-blue-600 dark:bg-blue-400 mt-2"></span>
                                                    <span>{highlight}</span>
                                                </li>
                                            ))}
                                        </ul>
                                    </div>
                                </motion.div>
                            ))}
                        </div>
                    </motion.div>

                    {/* Education */}
                    <motion.div
                        initial={{ opacity: 0, x: 50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.3, duration: 0.7 }}
                        className="space-y-10"
                    >
                        <div className="flex items-center gap-4 mb-10">
                            <div className="w-16 h-16 bg-gradient-to-br from-indigo-600 to-purple-600 rounded-2xl flex items-center justify-center shadow-lg">
                                <GraduationCap className="text-white" size={30} />
                            </div>
                            <div>
                                <h2 className="text-3xl font-bold text-gray-900 dark:text-white">Education</h2>
                                <p className="text-gray-500 dark:text-gray-400 text-sm mt-1">{experienceData.education.length} degrees</p>
                            </div>
                        </div>

                        <div className="space-y-12">
                            {experienceData.education.map((edu, index) => (
                                <motion.div
                                    key={edu.id}
                                    initial={{ opacity: 0, y: 30 }}
                                    animate={{ opacity: 1, y: 0 }}
                                    transition={{ delay: 0.4 + index * 0.15, duration: 0.6 }}
                                    className="glass-card hover-lift p-8 rounded-[2rem] border-white/40 dark:border-gray-800/50 group"
                                >
                                    <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-2 group-hover:text-indigo-600 dark:group-hover:text-indigo-400 transition-colors">
                                        {edu.title}
                                    </h3>
                                    <div className="text-lg font-bold text-indigo-600 dark:text-indigo-400 mb-4 px-4 py-1.5 bg-indigo-500/5 dark:bg-indigo-400/5 rounded-lg inline-block">
                                        {edu.institution}
                                    </div>

                                    <div className="flex flex-wrap gap-4 text-sm font-semibold text-gray-500 dark:text-gray-400 mb-6">
                                        <div className="flex items-center gap-2">
                                            <MapPin size={16} className="text-indigo-500" />
                                            <span>{edu.location}</span>
                                        </div>
                                        <div className="flex items-center gap-2 text-purple-500">
                                            <Calendar size={16} />
                                            <span>{new Date(edu.startDate).getFullYear()} - {new Date(edu.endDate).getFullYear()}</span>
                                        </div>
                                    </div>

                                    <p className="text-gray-600 dark:text-gray-400 mb-6 leading-relaxed">{edu.description}</p>

                                    <ul className="space-y-3">
                                        {edu.highlights.map((highlight, idx) => (
                                            <li key={idx} className="flex items-start gap-3 text-sm text-gray-600 dark:text-gray-400">
                                                <span className="flex-shrink-0 w-2 h-2 rounded-full bg-indigo-600 dark:bg-indigo-400 mt-2"></span>
                                                <span>{highlight}</span>
                                            </li>
                                        ))}
                                    </ul>
                                </motion.div>
                            ))}
                        </div>

                        {/* Certifications Section */}
                        <motion.div
                            initial={{ opacity: 0, y: 30 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.6, duration: 0.6 }}
                            className="glass-card p-8 rounded-[2rem] border-white/40 dark:border-gray-800/50"
                        >
                            <div className="flex items-center gap-4 mb-6">
                                <div className="w-12 h-12 bg-gradient-to-br from-yellow-500 to-orange-500 rounded-xl flex items-center justify-center shadow-lg">
                                    <Award className="text-white" size={24} />
                                </div>
                                <h3 className="text-2xl font-bold text-gray-900 dark:text-white">Certifications</h3>
                            </div>
                            <div className="space-y-4">
                                {[
                                    'Flutter & Dart - The Complete Guide',
                                    'Clean Architecture for Flutter',
                                    'Firebase for Flutter Developers',
                                ].map((cert, idx) => (
                                    <div key={idx} className="flex items-center gap-3 p-4 bg-white/50 dark:bg-gray-800/50 rounded-xl">
                                        <BookOpen size={18} className="text-yellow-500 flex-shrink-0" />
                                        <span className="text-gray-700 dark:text-gray-300 font-medium">{cert}</span>
                                    </div>
                                ))}
                            </div>
                        </motion.div>
                    </motion.div>
                </div>

                {/* Timeline Summary */}
                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.8, duration: 0.7 }}
                    className="mt-20 glass-card p-12 rounded-[3rem] border-white/40 dark:border-gray-800/50"
                >
                    <h2 className="text-3xl font-bold text-gray-900 dark:text-white mb-10 text-center">Career Timeline</h2>
                    <div className="flex flex-wrap justify-center gap-8">
                        {[
                            { year: '2020', event: 'Started Learning Flutter' },
                            { year: '2021', event: 'First Internship' },
                            { year: '2022', event: 'Junior Developer' },
                            { year: '2023', event: 'Mid-Level Developer' },
                            { year: '2026', event: 'Senior Developer' },
                        ].map((item, index) => (
                            <motion.div
                                key={index}
                                initial={{ opacity: 0, scale: 0.8 }}
                                animate={{ opacity: 1, scale: 1 }}
                                transition={{ delay: 1 + index * 0.1, duration: 0.5 }}
                                className="text-center"
                            >
                                <div className="text-4xl font-black text-gradient mb-2">{item.year}</div>
                                <div className="text-gray-600 dark:text-gray-400 font-medium">{item.event}</div>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            </div>
        </div>
    );
}
