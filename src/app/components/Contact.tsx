import { Mail, Phone, MapPin, Send, Github, Linkedin } from 'lucide-react';
import { useState } from 'react';
import profileData from '../../imports/profile.json';

export function Contact() {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    message: '',
  });

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    // Create mailto link
    const mailtoLink = `mailto:${profileData.email}?subject=Message from ${formData.name}&body=${formData.message}%0D%0A%0D%0AFrom: ${formData.name}%0D%0AEmail: ${formData.email}`;
    window.location.href = mailtoLink;
  };

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLTextAreaElement>) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  return (
    <section id="contact" className="py-24 bg-white dark:bg-gray-950 relative overflow-hidden">
      {/* Decorative Background Elements */}
      <div className="absolute top-0 right-0 w-96 h-96 bg-blue-500/5 rounded-full blur-[120px]"></div>
      <div className="absolute bottom-0 left-0 w-96 h-96 bg-indigo-500/5 rounded-full blur-[120px]"></div>

      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 relative z-10">
        <div className="text-center mb-16">
          <h2 className="text-4xl sm:text-6xl font-black mb-4 text-gray-900 dark:text-white tracking-tight">
            <span className="text-gradient">Get In Touch</span>
          </h2>
          <div className="w-24 h-1.5 bg-gradient-to-r from-blue-600 to-indigo-600 mx-auto mb-8 rounded-full shadow-sm"></div>
          <p className="text-xl text-gray-600 dark:text-gray-400 max-w-2xl mx-auto leading-relaxed">
            I'm always open to discussing new projects, creative ideas, or opportunities to be part of your visions.
          </p>
        </div>

        <div className="grid lg:grid-cols-2 gap-16">
          {/* Contact Information */}
          <div className="space-y-10">
            <h3 className="text-3xl font-bold text-gray-900 dark:text-white">Contact Information</h3>
            
            <div className="space-y-6">
              {[
                { icon: Mail, label: 'Email', value: profileData.email, href: `mailto:${profileData.email}` },
                { icon: Phone, label: 'Phone', value: profileData.phone, href: `tel:${profileData.phone}` },
                { icon: MapPin, label: 'Location', value: profileData.location, href: null }
              ].map((item, idx) => (
                <div key={idx} className="flex items-center gap-6 p-6 glass-card rounded-[2rem] hover-lift group">
                  <div className="w-14 h-14 bg-gradient-to-br from-blue-600 to-indigo-600 rounded-2xl flex items-center justify-center flex-shrink-0 shadow-lg group-hover:scale-110 transition-transform duration-300">
                    <item.icon className="text-white" size={28} />
                  </div>
                  <div>
                    <h4 className="text-sm font-bold uppercase tracking-widest text-gray-500 dark:text-gray-500 mb-1">{item.label}</h4>
                    {item.href ? (
                      <a href={item.href} className="text-xl font-bold text-gray-900 dark:text-white hover:text-blue-600 dark:hover:text-blue-400 transition-colors underline-offset-4 hover:underline">
                        {item.value}
                      </a>
                    ) : (
                      <p className="text-xl font-bold text-gray-900 dark:text-white">{item.value}</p>
                    )}
                  </div>
                </div>
              ))}
            </div>

            {/* Social Links */}
            <div className="pt-6">
              <h4 className="text-xl font-bold text-gray-900 dark:text-white mb-6">Connect with me</h4>
              <div className="flex gap-4">
                <a
                  href={profileData.socialLinks.github}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-14 h-14 glass-card flex items-center justify-center rounded-2xl hover:bg-gray-900 hover:text-white dark:hover:bg-white dark:hover:text-black transition-all hover:scale-110 active:scale-95 group shadow-lg"
                >
                  <Github size={24} className="group-hover:rotate-12 transition-transform" />
                </a>
                <a
                  href={profileData.socialLinks.linkedin}
                  target="_blank"
                  rel="noopener noreferrer"
                  className="w-14 h-14 glass-card flex items-center justify-center rounded-2xl hover:bg-blue-600 hover:text-white transition-all hover:scale-110 active:scale-95 group shadow-lg"
                >
                  <Linkedin size={24} className="group-hover:-rotate-12 transition-transform" />
                </a>
              </div>
            </div>
          </div>

          {/* Contact Form */}
          <div className="glass-card p-10 rounded-[3rem] border-white/40 dark:border-gray-800/50 shadow-2xl relative">
            <div className="absolute -top-6 -right-6 w-24 h-24 bg-blue-600/10 rounded-full blur-2xl animate-pulse"></div>
            
            <form onSubmit={handleSubmit} className="space-y-8">
              <div className="grid sm:grid-cols-2 gap-8">
                <div className="space-y-3">
                  <label htmlFor="name" className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                    Your Name
                  </label>
                  <input
                    type="text"
                    id="name"
                    name="name"
                    value={formData.name}
                    onChange={handleChange}
                    required
                    className="w-full px-6 py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-2xl focus:ring-2 focus:ring-blue-600 dark:focus:ring-blue-500 focus:border-transparent outline-none transition-all font-medium"
                    placeholder="John Doe"
                  />
                </div>

                <div className="space-y-3">
                  <label htmlFor="email" className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                    Your Email
                  </label>
                  <input
                    type="email"
                    id="email"
                    name="email"
                    value={formData.email}
                    onChange={handleChange}
                    required
                    className="w-full px-6 py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-2xl focus:ring-2 focus:ring-blue-600 dark:focus:ring-blue-500 focus:border-transparent outline-none transition-all font-medium"
                    placeholder="john@example.com"
                  />
                </div>
              </div>

              <div className="space-y-3">
                <label htmlFor="message" className="text-sm font-bold text-gray-700 dark:text-gray-300 ml-1">
                  Message
                </label>
                <textarea
                  id="message"
                  name="message"
                  value={formData.message}
                  onChange={handleChange}
                  required
                  rows={5}
                  className="w-full px-6 py-4 bg-gray-50 dark:bg-gray-900/50 border border-gray-200 dark:border-gray-800 text-gray-900 dark:text-white rounded-2xl focus:ring-2 focus:ring-blue-600 dark:focus:ring-blue-500 focus:border-transparent outline-none transition-all resize-none font-medium"
                  placeholder="Tell me about your project..."
                />
              </div>

              <button
                type="submit"
                className="w-full flex items-center justify-center gap-3 px-8 py-5 bg-gradient-to-r from-blue-600 to-indigo-600 text-white rounded-2xl hover:from-blue-700 hover:to-indigo-700 transition-all shadow-xl shadow-blue-500/25 hover:shadow-2xl hover:shadow-blue-500/40 font-bold active:scale-95 group"
              >
                <Send size={20} className="group-hover:translate-x-1 group-hover:-translate-y-1 transition-transform" />
                <span>Send Professional Inquiry</span>
              </button>
            </form>
          </div>
        </div>
      </div>
    </section>
  );
}
