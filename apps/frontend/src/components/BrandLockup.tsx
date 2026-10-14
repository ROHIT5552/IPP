import Image from 'next/image';

export function BrandLockup({
  priority = false,
  className = 'brand-lockup',
  alt = 'NewRa Grids',
}: {
  priority?: boolean;
  className?: string;
  alt?: string;
}) {
  return (
    <Image
      className={className}
      src="/brand/newra-grids-dark.png"
      alt={alt}
      width={999}
      height={128}
      priority={priority}
      sizes="312px"
    />
  );
}
