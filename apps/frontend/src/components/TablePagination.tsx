'use client';

import { ChevronLeft, ChevronRight } from 'lucide-react';

const PAGE_SIZES = [10, 25, 50, 100];

interface TablePaginationProps {
  recordCount: number;
  currentPage: number;
  pageSize: number;
  onPageChange: (page: number) => void;
  onPageSizeChange: (pageSize: number) => void;
  recordLabel: string;
}

function pageItems(currentPage: number, pageCount: number): Array<number | 'ellipsis-start' | 'ellipsis-end'> {
  if (pageCount <= 7) return Array.from({ length: pageCount }, (_, index) => index + 1);

  const visible = new Set([1, pageCount, currentPage, currentPage - 1, currentPage + 1]);
  if (currentPage <= 3) [2, 3, 4].forEach((page) => visible.add(page));
  if (currentPage >= pageCount - 2) [pageCount - 3, pageCount - 2, pageCount - 1].forEach((page) => visible.add(page));

  const pages = [...visible].filter((page) => page >= 1 && page <= pageCount).sort((left, right) => left - right);
  const items: Array<number | 'ellipsis-start' | 'ellipsis-end'> = [];
  pages.forEach((page, index) => {
    if (index > 0 && page - pages[index - 1] > 1) {
      items.push(index === 1 ? 'ellipsis-start' : 'ellipsis-end');
    }
    items.push(page);
  });
  return items;
}

export function TablePagination({
  recordCount,
  currentPage,
  pageSize,
  onPageChange,
  onPageSizeChange,
  recordLabel,
}: TablePaginationProps) {
  const pageCount = Math.max(1, Math.ceil(recordCount / pageSize));
  const start = recordCount ? (currentPage - 1) * pageSize + 1 : 0;
  const end = Math.min(currentPage * pageSize, recordCount);

  return (
    <div className="table-pager">
      <span>{recordCount ? `${start}–${end} of ${recordCount}` : `0 ${recordLabel}`}</span>
      <div className="pager-controls">
        <label>Rows
          <select
            className="filter-select"
            value={pageSize}
            onChange={(event) => onPageSizeChange(Number(event.target.value))}
            aria-label="Rows per page"
            style={{ marginLeft: 6 }}
          >
            {PAGE_SIZES.map((size) => <option key={size} value={size}>{size}</option>)}
          </select>
        </label>
        <button type="button" onClick={() => onPageChange(Math.max(1, currentPage - 1))} disabled={currentPage === 1} aria-label="Previous page">
          <ChevronLeft size={14} />
        </button>
        {pageItems(currentPage, pageCount).map((item) => typeof item === 'number' ? (
          <button type="button" key={item} onClick={() => onPageChange(item)} aria-current={item === currentPage ? 'page' : undefined}>{item}</button>
        ) : (
          <span className="pager-ellipsis" key={item} aria-hidden="true">…</span>
        ))}
        <button type="button" onClick={() => onPageChange(Math.min(pageCount, currentPage + 1))} disabled={currentPage === pageCount} aria-label="Next page">
          <ChevronRight size={14} />
        </button>
      </div>
    </div>
  );
}
