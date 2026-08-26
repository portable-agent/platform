import type {Config} from '@docusaurus/types';
import type {Options, ThemeConfig} from '@docusaurus/preset-classic';
import {themes as prismThemes} from 'prism-react-renderer';

const config: Config = {
  title: 'Portable Agent',
  tagline: 'Переносимый персональный AI-агент, превращающий намерение в безопасное действие',
  url: 'https://portable-agent.github.io',
  baseUrl: '/platform/',
  organizationName: 'portable-agent',
  projectName: 'platform',
  onBrokenLinks: 'throw',
  markdown: {
    mermaid: true,
    hooks: {
      onBrokenMarkdownLinks: 'throw',
    },
  },
  themes: ['@docusaurus/theme-mermaid'],
  i18n: {
    defaultLocale: 'ru',
    locales: ['ru'],
  },
  presets: [
    [
      'classic',
      {
        docs: {
          path: '../docs',
          routeBasePath: '/',
          sidebarPath: './sidebars.ts',
          editUrl: ({docPath}) =>
            `https://github.com/portable-agent/platform/edit/main/docs/${docPath}`,
        },
        blog: false,
        theme: {
          customCss: './src/css/custom.css',
        },
      } satisfies Options,
    ],
  ],
  themeConfig: {
    navbar: {
      title: 'Portable Agent',
      items: [
        {to: '/architecture/PLATFORM', label: 'Архитектура', position: 'left'},
        {to: '/delivery/ROADMAP', label: 'Дорожная карта', position: 'left'},
        {
          href: 'https://github.com/portable-agent/platform',
          label: 'GitHub',
          position: 'right',
        },
      ],
    },
    footer: {
      style: 'dark',
      copyright: `Copyright © ${new Date().getFullYear()} Portable Agent contributors. Apache-2.0.`,
    },
    mermaid: {
      theme: {light: 'neutral', dark: 'dark'},
    },
    prism: {
      theme: prismThemes.github,
      darkTheme: prismThemes.dracula,
    },
  } satisfies ThemeConfig,
};

export default config;
