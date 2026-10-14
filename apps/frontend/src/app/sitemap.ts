import type { MetadataRoute } from 'next';
import { SITE_URL } from '../seo/metadata';

const PUBLIC_PATHS = ['/', '/login', '/signup'];

export default function sitemap(): MetadataRoute.Sitemap {
  return PUBLIC_PATHS.map((path) => ({
    url: path === '/' ? SITE_URL : `${SITE_URL}${path}`,
    lastModified: new Date('2026-10-14'),
    changeFrequency: 'weekly',
    priority: path === '/' ? 1 : 0.8,
  }));
}
