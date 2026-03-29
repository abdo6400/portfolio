import { Mail, Phone, MapPin, Send, Github, Linkedin, MessageSquare, Clock, Globe } from 'lucide-react';
import { useState } from 'react';
import { motion } from 'motion/react';
import profileData from '../../imports/profile.json';

export function ContactPage() {
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        subject: '',
        message: '',
    });
    const [isSubmitting, setIsSubmitting] = useState(false);

    const handleSubmit = (e: React.FormEvent) => {
        e.preventDefault();
        setIsSubmitting(true);

        // Create mailto link
        const mailtoLink = `mailto:${profileData.email}?subject=${encodeURIComponent(formData.subject || `Message from ${formData.name}`)}&body=${encodeURIComponent(`Name: ${formData.name}\nEmail: ${formData.email}\n\n${formData.message}`)}`;

        setTimeout(() => {
            window.location.href = mailtoLink;
            setIsSubmitting(false);
        }, 500);
    };

    const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
        setFormData({
            ...formData,
            [e.target.name]: e.target.value,
        });
    };

    const contactInfo = [
        {
            icon: Mail,
            label: 'Email',
            value: profileData.email,
            href: `mailto:${profileData.email}`,
            description: 'Send me an email anytime'
        },
        {
            icon: Phone,
            label: 'Phone',
            value: profileData.phone,
            href: `tel:${profileData.phone}`,
            description: 'Call me during business hours'
        },
        {
            icon: MapPin,
            label: 'Location',
            value: profileData.location,
            href: null,
            description: 'Available for remote work'
        },
    ];

    return (
        <div className="min-h-screen py-20 sm:py-24 bg-white dark:bg-gray-950 relative overflow-hidden">
            {/* Decorative Background Elements */}
            <div className="absolute top-0 right-0 w-96 h-96 bg-cyan-500/5 rounded-full blur-[120px]"></div>
            <div className="absolute bottom-0 left-0 w-96 h-96 bg-violet-500/5 rounded-full blur-[120px]"></div>
            <div className="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-fuchsia-500/5 rounded-full blur-[100px]"></div>

            <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 30 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.7 }}
                    className="text-center mb-12 sm:mb-20"
                >
                    <h1 className="text-4xl sm:text-5xl lg:text-7xl font-black mb-4 sm:mb-6 text-gray-900 dark:text-white tracking-tight">
                        <span className="text-gradient">Get In Touch</span>
                    </h1>
                    <div className="w-24 sm:w-32 h-2 bg-gradient-to-r from-cyan-500 to-violet-600 mx-auto rounded-full shadow-lg mb-6 sm:mb-8"></div>
                    <p className="text-lg sm:text-xl text-gray-600 dark:text-gray-400 max-w-3xl mx-auto leading-relaxed">
                        I'm always open to discussing new projects, creative ideas, or opportunities to be part of your visions.
                    </p>
                </motion.div>

                <div className="grid lg:grid-cols-2 gap-8 sm:gap-16">
                    {/* Contact Information */}
                    <motion.div
                        initial={{ opacity: 0, x: -50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.2, duration: 0.7 }}
                        className="space-y-6 sm:space-y-10"
                    >
                        <div>
                            <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-2 sm:mb-3">Contact Information</h2>
                            <p className="text-gray-600 dark:text-gray-400">Feel free to reach out through any of these channels.</p>
                        </div>

                        <div className="space-y-4 sm:space-y-6">
                            {contactInfo.map((item, idx) => {
                                const Icon = item.icon;
                                return (
                                    <motion.div
                                        key={idx}
                                        initial={{ opacity: 0, y: 20 }}
                                        animate={{ opacity: 1, y: 0 }}
                                        transition={{ delay: 0.3 + idx * 0.1, duration: 0.5 }}
                                        className="flex items-center gap-4 sm:gap-6 p-4 sm:p-6 glass-card rounded-2xl sm:rounded-[2rem] hover-lift group"
                                    >
                                        <div className="w-12 h-12 sm:w-16 sm:h-16 bg-gradient-to-br from-cyan-500 to-violet-600 rounded-xl sm:rounded-2xl flex items-center justify-center flex-shrink-0 shadow-lg group-hover:scale-110 transition-transform duration-300">
                                            <Icon className="text-white" size={24} />
                                        </div>
                                        <div className="flex-1 min-w-0">
                                            <h4 className="text-xs sm:text-sm font-bold uppercase tracking-widest text-gray-500 dark:text-gray-500 mb-1">{item.label}</h4>
                                            {item.href ? (
                                                <a href={item.href} className="text-base sm:text-xl font-bold text-gray-900 dark:text-white hover:text-cyan-600 dark:hover:text-cyan-400 transition-colors underline-offset-4 hover:underline truncate block">
                                                    {item.value}
                                                </a>
                                            ) : (
                                                <p className="text-base sm:text-xl font-bold text-gray-900 dark:text-white truncate">{item.value}</p>
                                            )}
                                            <p className="text-xs sm:text-sm text-gray-500 dark:text-gray-400 mt-1 truncate">{item.description}</p>
                                        </div>
                                    </motion.div>
                                );
                            })}
                        </div>

                        {/* Social Links */}
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.6, duration: 0.5 }}
                            className="pt-4 sm:pt-6"
                        >
                            <h4 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white mb-4 sm:mb-6">Connect with me</h4>
                            <div className="flex gap-4">
                                <a
                                    href={profileData.socialLinks.github}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="w-12 h-12 sm:w-16 sm:h-16 glass-card flex items-center justify-center rounded-xl sm:rounded-2xl hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:scale-110 active:scale-95 group shadow-lg"
                                >
                                    <Github size={24} className="group-hover:rotate-12 transition-transform" />
                                </a>
                                <a
                                    href={profileData.socialLinks.linkedin}
                                    target="_blank"
                                    rel="noopener noreferrer"
                                    className="w-12 h-12 sm:w-16 sm:h-16 glass-card flex items-center justify-center rounded-xl sm:rounded-2xl hover:bg-cyan-600 hover:text-white transition-all hover:scale-110 active:scale-95 group shadow-lg"
                                >
                                    <Linkedin size={24} className="group-hover:-rotate-12 transition-transform" />
                                </a>
                            </div>
                        </motion.div>

                        {/* Availability Card */}
                        <motion.div
                            initial={{ opacity: 0, y: 20 }}
                            animate={{ opacity: 1, y: 0 }}
                            transition={{ delay: 0.7, duration: 0.5 }}
                            className="glass-card p-6 sm:p-8 rounded-2xl sm:rounded-[2rem] border-white/40 dark:border-gray-800/50"
                        >
                            <div className="flex items-center gap-3 sm:gap-4 mb-3 sm:mb-4">
                                <div className="w-10 h-10 sm:w-12 sm:h-12 bg-gradient-to-br from-emerald-500 to-teal-500 rounded-lg sm:rounded-xl flex items-center justify-center shadow-lg">
                                    <Clock className="text-white" size={20} />
                                </div>
                                <h3 className="text-lg sm:text-xl font-bold text-gray-900 dark:text-white">Availability</h3>
                            </div>
                            <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400 mb-3 sm:mb-4">
                                I'm currently available for freelance work and full-time opportunities.
                            </p>
                            <div className="flex items-center gap-2 text-emerald-600 dark:text-emerald-400 font-semibold text-sm sm:text-base">
                                <div className="w-2 h-2 sm:w-2.5 sm:h-2.5 bg-emerald-500 rounded-full animate-pulse"></div>
                                <span>Available for new projects</span>
                            </div>
                        </motion.div>
                    </motion.div>

                    {/* Contact Form */}
                    <motion.div
                        initial={{ opacity: 0, x: 50 }}
                        animate={{ opacity: 1, x: 0 }}
                        transition={{ delay: 0.3, duration: 0.7 }}
                        className="glass-card p-6 sm:p-10 rounded-2xl sm:rounded-[3rem] border-white/40 dark:border-gray-800/50 shadow-2xl relative"
                    >
                        <div className="absolute -top-4 -right-4 sm:-top-6 sm:-right-6 w-16 h-16 sm:w-24 sm:h-24 bg-cyan-600/10 rounded-full blur-2xl animate-pulse"></div>
                        <div className="absolute -bottom-4 -left-4 sm:-bottom-6 sm:-left-6 w-12 h-12 sm:w-20 sm:h-20 bg-violet-600/10 rounded-full blur-2xl animate-pulse delay-1000"></div>

                        <div className="relative z-10">
                            <div className="flex items-center gap-3 sm:gap-4 mb-6 sm:mb-8">
                                <div className="w-10 h-10 sm:w-12 sm:h-12 bg-gradient-to-br from-cyan-500 to-violet-600 rounded-lg sm:rounded-xl flex items-center justify-center shadow-lg">
                                    <MessageSquare className="text-white" size={20} />
                                </div>
                                <div>
                                    <h2 className="text-xl sm:text-2xl font-bold text-gray-900 dark:text-white">Send a Message</h2>
                                    <p className="text-xs sm:text-sm text-gray-500 dark:text-gray-400">I'll get back to you within 24 hours</p>
                                </div>
                            </div>

                            <form onSubmit={handleSubmit} className="space-y-4 sm:space-y-6">
                                <div className="grid sm:grid-cols-2 gap-4 sm:gap-6">
                                    <div className="space-y-2 sm:space-y-3">
                                        <label htmlFor="name" className="text-xs sm:text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                                            Your Name
                                        </label>
                                        <input
                                            type="text"
                                            id="name"
                                            name="name"
                                            value={formData.name}
                                            onChange={handleChange}
                                            required
                                            className="w-full px-4 sm:px-6 py-3 sm:py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-xl sm:rounded-2xl focus:ring-2 focus:ring-cyan-500 dark:focus:ring-cyan-400 focus:border-transparent outline-none transition-all font-medium text-sm sm:text-base"
                                            placeholder="John Doe"
                                        />
                                    </div>

                                    <div className="space-y-2 sm:space-y-3">
                                        <label htmlFor="email" className="text-xs sm:text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                                            Your Email
                                        </label>
                                        <input
                                            type="email"
                                            id="email"
                                            name="email"
                                            value={formData.email}
                                            onChange={handleChange}
                                            required
                                            className="w-full px-4 sm:px-6 py-3 sm:py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-xl sm:rounded-2xl focus:ring-2 focus:ring-cyan-500 dark:focus:ring-cyan-400 focus:border-transparent outline-none transition-all font-medium text-sm sm:text-base"
                                            placeholder="john@example.com"
                                        />
                                    </div>
                                </div>

                                <div className="space-y-2 sm:space-y-3">
                                    <label htmlFor="subject" className="text-xs sm:text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                                        Subject
                                    </label>
                                    <input
                                        type="text"
                                        id="subject"
                                        name="subject"
                                        value={formData.subject}
                                        onChange={handleChange}
                                        className="w-full px-4 sm:px-6 py-3 sm:py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-xl sm:rounded-2xl focus:ring-2 focus:ring-cyan-500 dark:focus:ring-cyan-400 focus:border-transparent outline-none transition-all font-medium text-sm sm:text-base"
                                        placeholder="Project Inquiry"
                                    />
                                </div>

                                <div className="space-y-2 sm:space-y-3">
                                    <label htmlFor="message" className="text-xs sm:text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                                        Message
                                    </label>
                                    <textarea
                                        id="message"
                                        name="message"
                                        value={formData.message}
                                        onChange={handleChange}
                                        required
                                        rows={4}
                                        className="w-full px-4 sm:px-6 py-3 sm:py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-xl sm:rounded-2xl focus:ring-2 focus:ring-cyan-500 dark:focus:ring-cyan-400 focus:border-transparent outline-none transition-all resize-none font-medium text-sm sm:text-base"
                                        placeholder="Tell me about your project..."
                                    />
                                </div>

                                <button
                                    type="submit"
                                    disabled={isSubmitting}
                                    className="w-full flex items-center justify-center gap-2 sm:gap-3 px-6 sm:px-8 py-4 sm:py-5 bg-gradient-to-r from-cyan-500 to-violet-600 text-white rounded-xl sm:rounded-2xl hover:from-cyan-600 hover:to-violet-700 transition-all shadow-xl shadow-cyan-500/25 hover:shadow-2xl hover:shadow-cyan-500/40 font-bold active:scale-95 group disabled:opacity-70 disabled:cursor-not-allowed text-sm sm:text-base"
                                >
                                    {isSubmitting ? (
                                        <>
                                            <div className="w-4 h-4 sm:w-5 sm:h-5 border-2 border-white/30 border-t-white rounded-full animate-spin"></div>
                                            <span>Sending...</span>
                                        </>
                                    ) : (
                                        <>
                                            <Send size={18} className="group-hover:translate-x-1 group-hover:-translate-y-1 transition-transform" />
                                            <span>Send Message</span>
                                        </>
                                    )}
                                </button>
                            </form>
                        </div>
                    </motion.div>
                </div>

                {/* FAQ Section */}
                <motion.div
                    initial={{ opacity: 0, y: 50 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ delay: 0.8, duration: 0.7 }}
                    className="mt-12 sm:mt-20 glass-card p-6 sm:p-12 rounded-2xl sm:rounded-[3rem] border-white/40 dark:border-gray-800/50"
                >
                    <h2 className="text-2xl sm:text-3xl font-bold text-gray-900 dark:text-white mb-6 sm:mb-10 text-center">Frequently Asked Questions</h2>
                    <div className="grid sm:grid-cols-2 gap-4 sm:gap-8">
                        {[
                            { q: 'What is your typical response time?', a: 'I usually respond within 24 hours during business days.' },
                            { q: 'Do you work remotely?', a: 'Yes, I work remotely and am available for clients worldwide.' },
                            { q: 'What types of projects do you take?', a: 'I specialize in mobile app development using Flutter, but also work on web projects.' },
                            { q: 'What is your availability?', a: 'I am currently available for both freelance and full-time opportunities.' },
                        ].map((faq, index) => (
                            <motion.div
                                key={index}
                                initial={{ opacity: 0, y: 20 }}
                                animate={{ opacity: 1, y: 0 }}
                                transition={{ delay: 1 + index * 0.1, duration: 0.5 }}
                                className="p-4 sm:p-6 bg-white/50 dark:bg-gray-800/50 rounded-xl sm:rounded-2xl"
                            >
                                <h4 className="text-base sm:text-lg font-bold text-gray-900 dark:text-white mb-2 sm:mb-3">{faq.q}</h4>
                                <p className="text-sm sm:text-base text-gray-600 dark:text-gray-400">{faq.a}</p>
                            </motion.div>
                        ))}
                    </div>
                </motion.div>
            </div>
        </div>
    );
}
