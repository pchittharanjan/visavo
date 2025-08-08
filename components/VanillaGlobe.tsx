'use client'

import { useEffect, useRef, useState } from 'react'

interface VanillaGlobeProps {
  countries: Array<{
    lat: number
    lng: number
    color: string
    country: string
    name: string
    status: string
  }>
  onCountryClick: (countryCode: string) => void
  searchTerm: string
}

export default function VanillaGlobe({ countries, onCountryClick, searchTerm }: VanillaGlobeProps) {
  console.log('VanillaGlobe: Component rendered with', countries.length, 'countries')
  console.log('VanillaGlobe: Search term:', searchTerm)
  
  const mountRef = useRef<HTMLDivElement>(null)
  const [isLoading, setIsLoading] = useState(true)

  useEffect(() => {
    console.log('VanillaGlobe: useEffect triggered')
    console.log('VanillaGlobe: mountRef.current:', mountRef.current)
    console.log('VanillaGlobe: container dimensions:', mountRef.current?.clientWidth, 'x', mountRef.current?.clientHeight)
    
    if (!mountRef.current) {
      console.log('VanillaGlobe: No mount ref, returning')
      return
    }

    // Dynamically import Three.js to avoid SSR issues
    const initGlobe = async () => {
      try {
        console.log('VanillaGlobe: Starting Three.js import...')
        const THREE = await import('three')
        console.log('VanillaGlobe: Three.js imported successfully')
        
        // Scene setup
        const scene = new THREE.Scene()

        // Camera setup
        const camera = new THREE.PerspectiveCamera(
          45,
          mountRef.current!.clientWidth / mountRef.current!.clientHeight,
          0.1,
          1000
        )
        camera.position.set(0, 0, 2.5)

        // Renderer setup
        const renderer = new THREE.WebGLRenderer({ antialias: true, alpha: true })
        renderer.setSize(mountRef.current!.clientWidth, mountRef.current!.clientHeight)
        renderer.setClearColor(0x000000, 0)
        renderer.setPixelRatio(Math.min(window.devicePixelRatio, 2))
        mountRef.current!.appendChild(renderer.domElement)

        // Earth sphere
        const earthGeometry = new THREE.SphereGeometry(1, 32, 32)
        const earthMaterial = new THREE.MeshBasicMaterial({
          color: 0x4B6CB7,
          transparent: true,
          opacity: 0.8
        })
        const earth = new THREE.Mesh(earthGeometry, earthMaterial)
        scene.add(earth)

        // Atmosphere
        const atmosphereGeometry = new THREE.SphereGeometry(1.1, 32, 32)
        const atmosphereMaterial = new THREE.MeshBasicMaterial({
          color: 0x87CEEB,
          transparent: true,
          opacity: 0.1,
          side: THREE.BackSide
        })
        const atmosphere = new THREE.Mesh(atmosphereGeometry, atmosphereMaterial)
        scene.add(atmosphere)

        // Lighting
        const ambientLight = new THREE.AmbientLight(0x404040, 0.3)
        scene.add(ambientLight)

        const directionalLight = new THREE.DirectionalLight(0xffffff, 1)
        directionalLight.position.set(10, 10, 5)
        scene.add(directionalLight)

        // Controls (simple orbit controls)
        let isMouseDown = false
        let mouseX = 0
        let mouseY = 0
        let rotationX = 0
        let rotationY = 0

        const handleMouseDown = (event: MouseEvent) => {
          isMouseDown = true
          mouseX = event.clientX
          mouseY = event.clientY
        }

        const handleMouseMove = (event: MouseEvent) => {
          if (!isMouseDown) return

          const deltaX = event.clientX - mouseX
          const deltaY = event.clientY - mouseY

          rotationY += deltaX * 0.01
          rotationX += deltaY * 0.01

          rotationX = Math.max(-Math.PI / 2, Math.min(Math.PI / 2, rotationX))

          earth.rotation.x = rotationX
          earth.rotation.y = rotationY
          atmosphere.rotation.x = rotationX
          atmosphere.rotation.y = rotationY

          mouseX = event.clientX
          mouseY = event.clientY
        }

        const handleMouseUp = () => {
          isMouseDown = false
        }

        const handleWheel = (event: WheelEvent) => {
          const zoomSpeed = 0.1
          const delta = event.deltaY > 0 ? 1 : -1
          const newZ = camera.position.z + delta * zoomSpeed
          camera.position.z = Math.max(1.5, Math.min(4, newZ))
        }

        renderer.domElement.addEventListener('mousedown', handleMouseDown)
        renderer.domElement.addEventListener('mousemove', handleMouseMove)
        renderer.domElement.addEventListener('mouseup', handleMouseUp)
        renderer.domElement.addEventListener('wheel', handleWheel)

        // Raycaster for country selection
        const raycaster = new THREE.Raycaster()
        const mouse = new THREE.Vector2()

        const handleClick = (event: MouseEvent) => {
          const rect = renderer.domElement.getBoundingClientRect()
          mouse.x = ((event.clientX - rect.left) / rect.width) * 2 - 1
          mouse.y = -((event.clientY - rect.top) / rect.height) * 2 + 1

          raycaster.setFromCamera(mouse, camera)
          const intersects = raycaster.intersectObjects(scene.children, true)

          if (intersects.length > 0) {
            const clickedObject = intersects[0].object
            if (clickedObject.userData.countryCode) {
              onCountryClick(clickedObject.userData.countryCode)
            }
          }
        }

        renderer.domElement.addEventListener('click', handleClick)

        // Animation loop
        let animationId: number
        const animate = () => {
          animationId = requestAnimationFrame(animate)
          renderer.render(scene, camera)
        }
        animate()

        // Update country markers when countries or search term changes
        const updateMarkers = () => {
          // Remove existing country markers
          const existingMarkers = scene.children.filter(child => 
            child.userData.type === 'countryMarker'
          )
          existingMarkers.forEach(marker => scene.remove(marker))

          // Filter countries based on search term
          const filteredCountries = searchTerm 
            ? countries.filter(country => 
                country.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
                country.country.toLowerCase().includes(searchTerm.toLowerCase())
              )
            : countries

          // Add new country markers
          filteredCountries.forEach(country => {
            // Convert lat/lng to 3D position
            const phi = (90 - country.lat) * (Math.PI / 180)
            const theta = (country.lng + 180) * (Math.PI / 180)
            const radius = 1.01

            const x = -(radius * Math.sin(phi) * Math.cos(theta))
            const z = radius * Math.sin(phi) * Math.sin(theta)
            const y = radius * Math.cos(phi)

            const markerGeometry = new THREE.SphereGeometry(0.02, 8, 8)
            const markerMaterial = new THREE.MeshBasicMaterial({
              color: country.color,
              transparent: true,
              opacity: 0.8
            })

            const marker = new THREE.Mesh(markerGeometry, markerMaterial)
            marker.position.set(x, y, z)
            marker.userData = {
              type: 'countryMarker',
              countryCode: country.country,
              countryName: country.name
            }

            scene.add(marker)
          })
        }

        // Initial markers
        updateMarkers()

        // Cleanup function
        const cleanup = () => {
          if (animationId) {
            cancelAnimationFrame(animationId)
          }
          if (mountRef.current && renderer.domElement) {
            mountRef.current.removeChild(renderer.domElement)
          }
          renderer.dispose()
        }

        // Store cleanup function
        ;(mountRef.current as any).cleanup = cleanup

        setIsLoading(false)

        // Return cleanup function
        return cleanup
      } catch (error) {
        console.error('Failed to initialize Three.js globe:', error)
        setIsLoading(false)
      }
    }

    initGlobe()

    // Cleanup on unmount
    return () => {
      if ((mountRef.current as any)?.cleanup) {
        ;(mountRef.current as any).cleanup()
      }
    }
  }, [countries, searchTerm, onCountryClick])

  return (
    <div 
      ref={mountRef} 
      className="w-full h-full relative"
      style={{ background: 'linear-gradient(to bottom, #1e3a8a, #3b82f6)' }}
    >
      {isLoading && (
        <div className="absolute inset-0 flex items-center justify-center">
          <div className="text-white text-center">
            <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-white mx-auto mb-4"></div>
            <p className="text-sm">Loading 3D Globe...</p>
          </div>
        </div>
      )}
    </div>
  )
} 