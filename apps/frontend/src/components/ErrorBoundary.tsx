'use client';

import { Component, PropsWithChildren } from 'react';
import { RouteErrorScreen } from './StatusScreens';

type BoundaryState = { error: Error | null };

export class ErrorBoundary extends Component<PropsWithChildren, BoundaryState> {
  state: BoundaryState = { error: null };

  static getDerivedStateFromError(error: Error): BoundaryState {
    return { error };
  }

  reset = () => this.setState({ error: null });

  render() {
    if (this.state.error) return <RouteErrorScreen reset={this.reset} />;
    return this.props.children;
  }
}
