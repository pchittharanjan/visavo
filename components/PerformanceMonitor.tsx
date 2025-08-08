'use client'

import { useState, useEffect } from 'react'
import { getCacheStats } from '@/lib/optimized-database'
import { Clock, Database, Zap } from 'lucide-react'

interface PerformanceStats {
  cacheSize: number
  maxCacheSize: number
  cacheHitRate: number
  queryCount: number
  averageQueryTime: number
}

export default function PerformanceMonitor() {
  const [stats, setStats] = useState<PerformanceStats>({
    cacheSize: 0,
    maxCacheSize: 1000,
    cacheHitRate: 0,
    queryCount: 0,
    averageQueryTime: 0
  })
  const [isVisible, setIsVisible] = useState(false)

  useEffect(() => {
    const updateStats = () => {
      const cacheStats = getCacheStats()
      setStats(prev => ({
        ...prev,
        cacheSize: cacheStats.size,
        maxCacheSize: cacheStats.maxSize,
        cacheHitRate: cacheStats.size > 0 ? Math.round((cacheStats.size / cacheStats.maxSize) * 100) : 0
      }))
    }

    // Update stats every 5 seconds
    const interval = setInterval(updateStats, 5000)
    updateStats() // Initial update

    return () => clearInterval(interval)
  }, [])

  if (!isVisible) {
    return (
      <button
        onClick={() => setIsVisible(true)}
        className="fixed bottom-4 right-4 bg-blue-500 hover:bg-blue-600 text-white p-2 rounded-full shadow-lg transition-colors"
        title="Show Performance Monitor"
      >
        <Zap size={20} />
      </button>
    )
  }

  return (
    <div className="fixed bottom-4 right-4 bg-white dark:bg-gray-800 border border-gray-200 dark:border-gray-700 rounded-lg shadow-lg p-4 w-64 z-50">
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-sm font-semibold text-gray-900 dark:text-white flex items-center gap-2">
          <Database size={16} />
          Performance Monitor
        </h3>
        <button
          onClick={() => setIsVisible(false)}
          className="text-gray-400 hover:text-gray-600 dark:hover:text-gray-300"
        >
          ×
        </button>
      </div>

      <div className="space-y-2 text-xs">
        <div className="flex items-center justify-between">
          <span className="text-gray-600 dark:text-gray-400">Cache Usage:</span>
          <span className="font-mono">
            {stats.cacheSize}/{stats.maxCacheSize}
          </span>
        </div>

        <div className="flex items-center justify-between">
          <span className="text-gray-600 dark:text-gray-400">Cache Hit Rate:</span>
          <span className={`font-mono ${stats.cacheHitRate > 50 ? 'text-green-600' : 'text-yellow-600'}`}>
            {stats.cacheHitRate}%
          </span>
        </div>

        <div className="flex items-center justify-between">
          <span className="text-gray-600 dark:text-gray-400">Query Count:</span>
          <span className="font-mono">{stats.queryCount}</span>
        </div>

        <div className="flex items-center justify-between">
          <span className="text-gray-600 dark:text-gray-400">Avg Query Time:</span>
          <span className="font-mono">{stats.averageQueryTime}ms</span>
        </div>

        <div className="pt-2 border-t border-gray-200 dark:border-gray-700">
          <div className="flex items-center gap-2 text-gray-500 dark:text-gray-400">
            <Clock size={12} />
            <span className="text-xs">Updated every 5s</span>
          </div>
        </div>
      </div>
    </div>
  )
}
