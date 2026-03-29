import { useState, useEffect, useCallback } from 'react';
import { Link, useLocation } from 'react-router';
import {
  Menu, X, Moon, Sun, Code2,
  Home, User, Briefcase, FolderOpen, Mail, Sparkles,
  ChevronRight,
} from 'lucide-react';
import { useTheme } from 'next-themes';

const NAV_ITEMS = [
  { path: '/', label: 'Home', icon: Home },
  { path: '/about', label: 'About', icon: User },
  { path: '/skills', label: 'Skills', icon: Sparkles },
  { path: '/experience', label: 'Experience', icon: Briefcase },
  { path: '/projects', label: 'Projects', icon: FolderOpen },
  { path: '/contact', label: 'Contact', icon: Mail },
] as const;

export function Navigation() {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);
  const [mounted, setMounted] = useState(false);
  const { theme, setTheme } = useTheme();
  const location = useLocation();

  /* ── mount + scroll listener ── */
  useEffect(() => {
    setMounted(true);
    const onScroll = () => setIsScrolled(window.scrollY > 20);
    window.addEventListener('scroll', onScroll, { passive: true });
    return () => window.removeEventListener('scroll', onScroll);
  }, []);

  /* ── close drawer on route change ── */
  useEffect(() => {
    setIsMobileMenuOpen(false);
  }, [location.pathname]);

  /* ── body scroll-lock when drawer is open ── */
  useEffect(() => {
    document.body.style.overflow = isMobileMenuOpen ? 'hidden' : '';
    return () => { document.body.style.overflow = ''; };
  }, [isMobileMenuOpen]);

  const closeSelf = useCallback(() => setIsMobileMenuOpen(false), []);
  const toggleMenu = useCallback(() => setIsMobileMenuOpen(v => !v), []);

  const isActive = (path: string) =>
    path === '/' ? location.pathname === '/' : location.pathname.startsWith(path);

  return (
    <>
      {/* ══════════════════════════════════════ NAV BAR ══ */}
      <nav
        className={`fixed top-0 w-full z-[55] transition-all duration-500 ${isScrolled ? 'py-0' : 'py-2'
          }`}
      >
        <div
          className={`mx-auto transition-all duration-500 ${isScrolled
            ? 'max-w-full px-0'
            : 'max-w-5xl px-4 sm:px-6 mt-3'
            }`}
        >
          <div
            className={`flex justify-between items-center px-4 sm:px-8 h-14 sm:h-16 transition-all duration-500 ${isScrolled
              ? 'bg-white/90 dark:bg-gray-950/90 backdrop-blur-xl shadow-lg shadow-black/10 border-b border-gray-200/60 dark:border-gray-800/60 rounded-none'
              : 'bg-white/70 dark:bg-gray-950/70 backdrop-blur-xl border border-gray-200/60 dark:border-gray-700/40 rounded-2xl shadow-xl shadow-black/5'
              }`}
          >
            {/* Logo */}
            <Link to="/" className="flex items-center gap-2 group">
              <div className="w-8 h-8 rounded-xl bg-gradient-to-br from-cyan-500 to-violet-600 flex items-center justify-center shadow-md group-hover:scale-110 transition-transform duration-200">
                <Code2 size={15} className="text-white" />
              </div>
              <span className="text-sm sm:text-base font-bold text-gray-900 dark:text-white hidden sm:inline">
                Abdulrahman<span className="text-cyan-600 dark:text-cyan-400">Amr</span>
              </span>
            </Link>

            {/* Desktop nav links */}
            <div className="hidden md:flex items-center gap-1">
              {NAV_ITEMS.map((item) => (
                <Link
                  key={item.path}
                  to={item.path}
                  className={`relative px-4 py-2 text-sm font-medium rounded-xl transition-all duration-200 ${isActive(item.path)
                    ? 'text-cyan-600 dark:text-cyan-400 bg-cyan-50 dark:bg-cyan-500/10'
                    : 'text-gray-600 dark:text-gray-400 hover:text-gray-900 dark:hover:text-white hover:bg-gray-100/80 dark:hover:bg-gray-800/60'
                    }`}
                >
                  {item.label}
                  {isActive(item.path) && (
                    <span className="absolute bottom-1 left-1/2 -translate-x-1/2 w-1 h-1 rounded-full bg-cyan-600 dark:bg-cyan-400" />
                  )}
                </Link>
              ))}
            </div>

            {/* Right actions */}
            <div className="flex items-center gap-2">
              {/* Theme toggle */}
              {mounted && (
                <button
                  onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                  className="w-9 h-9 flex items-center justify-center rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-600 dark:text-gray-400 hover:bg-gray-200 dark:hover:bg-gray-700 hover:text-gray-900 dark:hover:text-white transition-all duration-200"
                  aria-label="Toggle theme"
                >
                  {theme === 'dark'
                    ? <Sun size={17} />
                    : <Moon size={17} />
                  }
                </button>
              )}

              {/* Hire me CTA — desktop only */}
              <Link
                to="/contact"
                className="hidden sm:flex items-center gap-1.5 px-4 py-2 bg-gradient-to-r from-cyan-500 to-violet-600 hover:from-cyan-600 hover:to-violet-700 text-white text-sm font-semibold rounded-xl shadow-md hover:shadow-cyan-500/30 hover:scale-105 transition-all duration-200"
              >
                Hire Me
              </Link>

              {/* Mobile hamburger */}
              <button
                id="mobile-menu-toggle"
                onClick={toggleMenu}
                className="md:hidden w-10 h-10 flex items-center justify-center rounded-xl bg-gray-100 dark:bg-gray-800 text-gray-700 dark:text-gray-300 hover:bg-gray-200 dark:hover:bg-gray-700 transition-all active:scale-90"
                aria-label="Toggle menu"
                aria-expanded={isMobileMenuOpen}
              >
                <span
                  className="relative w-5 h-5 flex items-center justify-center"
                  style={{ transition: 'transform 300ms' }}
                >
                  <Menu
                    size={20}
                    className={`absolute transition-all duration-300 ${isMobileMenuOpen ? 'opacity-0 rotate-90 scale-50' : 'opacity-100 rotate-0 scale-100'
                      }`}
                  />
                  <X
                    size={20}
                    className={`absolute transition-all duration-300 ${isMobileMenuOpen ? 'opacity-100 rotate-0 scale-100' : 'opacity-0 -rotate-90 scale-50'
                      }`}
                  />
                </span>
              </button>
            </div>
          </div>
        </div>
      </nav>

      {/* ══════════════════════════════════ MOBILE DRAWER ══ */}
      {/* Full-screen overlay — z-[60] beats nav (z-[55]) and chat button (z-50) */}
      <div
        className={`fixed inset-0 z-[60] md:hidden transition-all duration-300 ${isMobileMenuOpen
          ? 'opacity-100 pointer-events-auto'
          : 'opacity-0 pointer-events-none'
          }`}
        aria-hidden={!isMobileMenuOpen}
      >
        {/* Backdrop */}
        <div
          className="absolute inset-0 bg-black/50 backdrop-blur-sm"
          onClick={closeSelf}
        />

        {/* ── Slide-in panel ── */}
        <div
          className={`absolute right-0 top-0 h-full w-[85vw] max-w-[340px] flex flex-col transition-transform duration-350 ease-[cubic-bezier(.32,.72,0,1)] ${isMobileMenuOpen ? 'translate-x-0' : 'translate-x-full'
            }`}

        // dark mode override via class
        >
          {/* Dark-mode background gradient override */}
          <div className="absolute inset-0 dark:bg-gray-950 rounded-l-3xl overflow-hidden">
            {/* subtle gradient accent top-right */}
            <div className="absolute -top-24 -right-24 w-64 h-64 rounded-full bg-gradient-to-br from-cyan-500/10 to-violet-600/10 blur-3xl pointer-events-none" />
            <div className="absolute bottom-0 left-0 w-48 h-48 rounded-full bg-gradient-to-tr from-violet-500/8 to-cyan-500/8 blur-2xl pointer-events-none" />
          </div>

          {/* actual content — fully opaque so nothing bleeds through */}
          <div className="relative z-10 flex flex-col h-full rounded-l-3xl overflow-hidden
            bg-white dark:bg-gray-950
            border-l border-gray-200 dark:border-gray-800
            shadow-2xl shadow-black/30">

            {/* ── Header ── */}
            <div className="flex items-center justify-between px-5 pt-6 pb-5 border-b border-gray-100 dark:border-gray-800/80">
              <Link to="/" onClick={closeSelf} className="flex items-center gap-3 group">
                <div className="w-10 h-10 rounded-2xl bg-gradient-to-br from-cyan-500 to-violet-600 flex items-center justify-center shadow-lg shadow-cyan-500/30 group-hover:scale-110 transition-transform duration-200">
                  <Code2 size={18} className="text-white" />
                </div>
                <div className="flex flex-col leading-tight">
                  <span className="font-bold text-gray-900 dark:text-white text-sm">Abdulrahman</span>
                  <span className="text-xs font-semibold text-cyan-600 dark:text-cyan-400 tracking-wide">Amr</span>
                </div>
              </Link>

              <button
                onClick={closeSelf}
                className="w-9 h-9 flex items-center justify-center rounded-xl text-gray-400 dark:text-gray-500 hover:text-gray-700 dark:hover:text-gray-200 hover:bg-gray-100 dark:hover:bg-gray-800 transition-all active:scale-90"
                aria-label="Close menu"
              >
                <X size={18} />
              </button>
            </div>

            {/* ── Navigation items ── */}
            <nav className="flex-1 px-3 py-4 space-y-1 overflow-y-auto">
              {NAV_ITEMS.map((item, i) => {
                const Icon = item.icon;
                const active = isActive(item.path);
                return (
                  <Link
                    key={item.path}
                    to={item.path}
                    onClick={closeSelf}
                    className={`group flex items-center gap-4 px-4 py-3.5 rounded-2xl transition-all duration-200 ${active
                      ? 'bg-gradient-to-r from-cyan-50 to-violet-50 dark:from-cyan-500/10 dark:to-violet-500/10'
                      : 'hover:bg-gray-50 dark:hover:bg-gray-800/50'
                      }`}
                    style={{
                      animationDelay: `${i * 45}ms`,
                      opacity: isMobileMenuOpen ? 1 : 0,
                      transform: isMobileMenuOpen ? 'translateX(0)' : 'translateX(20px)',
                      transition: `opacity 300ms ease ${i * 45}ms, transform 300ms ease ${i * 45}ms, background 200ms ease`,
                    }}
                  >
                    {/* Icon container */}
                    <div
                      className={`w-10 h-10 rounded-xl flex items-center justify-center flex-shrink-0 transition-all duration-200 ${active
                        ? 'bg-gradient-to-br from-cyan-500 to-violet-600 text-white shadow-md shadow-cyan-500/30'
                        : 'bg-gray-100 dark:bg-gray-800 text-gray-500 dark:text-gray-400 group-hover:bg-gray-200 dark:group-hover:bg-gray-700 group-hover:text-gray-700 dark:group-hover:text-gray-200'
                        }`}
                    >
                      <Icon size={19} />
                    </div>

                    {/* Label */}
                    <span
                      className={`flex-1 font-semibold text-sm transition-colors duration-200 ${active
                        ? 'text-gray-900 dark:text-white'
                        : 'text-gray-600 dark:text-gray-400 group-hover:text-gray-900 dark:group-hover:text-white'
                        }`}
                    >
                      {item.label}
                    </span>

                    {/* Right indicator */}
                    {active ? (
                      <span className="w-2 h-2 rounded-full bg-gradient-to-br from-cyan-500 to-violet-500 shadow-sm shadow-cyan-500/40" />
                    ) : (
                      <ChevronRight
                        size={15}
                        className="text-gray-300 dark:text-gray-600 group-hover:text-gray-400 dark:group-hover:text-gray-400 transition-colors"
                      />
                    )}
                  </Link>
                );
              })}
            </nav>

            {/* ── Footer ── */}
            <div className="px-4 py-5 border-t border-gray-100 dark:border-gray-800/80 space-y-3">
              {/* Hire Me CTA */}
              <Link
                to="/contact"
                onClick={closeSelf}
                className="flex items-center justify-center gap-2 w-full py-3.5 bg-gradient-to-r from-cyan-500 to-violet-600 hover:from-cyan-600 hover:to-violet-700 text-white text-sm font-bold rounded-2xl shadow-lg shadow-cyan-500/25 hover:shadow-cyan-500/40 hover:scale-[1.02] active:scale-[0.98] transition-all duration-200"
              >
                <Mail size={16} />
                Hire Me
              </Link>

              {/* Theme toggle pill */}
              <button
                onClick={() => setTheme(theme === 'dark' ? 'light' : 'dark')}
                className="flex items-center justify-between w-full px-4 py-3 rounded-2xl bg-gray-50 dark:bg-gray-800/60 hover:bg-gray-100 dark:hover:bg-gray-800 transition-all duration-200 active:scale-[0.99]"
              >
                <span className="text-sm font-medium text-gray-600 dark:text-gray-400">
                  {theme === 'dark' ? 'Light' : 'Dark'} Mode
                </span>
                <div className="flex items-center gap-2">
                  {mounted && (
                    theme === 'dark'
                      ? <Sun size={16} className="text-amber-400" />
                      : <Moon size={16} className="text-violet-500" />
                  )}
                  <div className={`w-9 h-5 rounded-full relative transition-colors duration-300 ${theme === 'dark' ? 'bg-cyan-500' : 'bg-gray-300 dark:bg-gray-600'
                    }`}>
                    <div className={`absolute top-0.5 w-4 h-4 rounded-full bg-white shadow-sm transition-transform duration-300 ${theme === 'dark' ? 'translate-x-4' : 'translate-x-0.5'
                      }`} />
                  </div>
                </div>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
