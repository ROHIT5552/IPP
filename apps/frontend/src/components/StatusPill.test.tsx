import '@testing-library/jest-dom';
import { render, screen } from '@testing-library/react';
import { StatusPill } from './StatusPill';

describe('StatusPill', () => {
  it('humanizes workflow statuses and applies the relevant state class', () => {
    render(<StatusPill status="UNDER_REVIEW" />);
    expect(screen.getByText('Under Review')).toHaveClass('status-warn');
  });

  it('keeps a failed gate visually distinct', () => {
    render(<StatusPill status="FAIL" />);
    expect(screen.getByText('Fail')).toHaveClass('status-risk');
  });
});
