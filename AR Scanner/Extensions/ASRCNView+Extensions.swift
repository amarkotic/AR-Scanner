import ARKit

extension ARSCNView {

    func configure(_ session: ARSession) {
        self.session = session
        antialiasingMode = .multisampling4X
        preferredFramesPerSecond = 60
        if let camera = pointOfView?.camera {
            camera.exposureOffset = -1
            camera.minimumExposure = -1
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
        }
    }

}
