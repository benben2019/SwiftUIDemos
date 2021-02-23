//
//  CameraView.swift
//  CustomCamera
//
//  Created by Ben on 2021/2/23.
//

import SwiftUI
import AVFoundation

struct CameraView: View {
    
    @StateObject var camera = CameraModel()
    
    var body: some View {
        ZStack {
            CameraPreview(camera: camera)
                .ignoresSafeArea()
            
            VStack {
                
                if camera.isTaken {
                    HStack {
                        Spacer()
                        Button(action: camera.reTakePickture, label: {
                            Image(systemName: "camera")
                                .foregroundColor(.black)
                                .padding()
                                .background(Color.white)
                                .clipShape(Circle())
                        })
                        .padding(.trailing)
                        
                    }
                }
                
                Spacer()
                
                HStack {
                    if camera.isTaken {
                        Button(action: { if !camera.isSaved { camera.savePicture() } }, label: {
                            Text(camera.isSaved ? "Saved " : "Save")
                                .foregroundColor(.black)
                                .fontWeight(.semibold)
                                .padding(.vertical,10)
                                .padding(.horizontal,20)
                                .background(Color.white)
                                .clipShape(Capsule())
                        })
                        .padding(.leading)
                        
                        Spacer()
                        
                    } else {
                        Button(action: camera.takePickture, label: {
                            ZStack {
                                Circle()
                                    .fill(Color.white)
                                    .frame(width: 65,height: 65)
                                
                                Circle()
                                    .stroke(Color.white,lineWidth: 2)
                                    .frame(width: 75,height: 75)
                            }
                        })
                    }
                }
                .frame(height: 75)
            }
        }
        .onAppear(perform: {
            camera.checkAuthorization()
        })
    }
}

class CameraModel: NSObject,ObservableObject,AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var alert = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var isSaved = false
    @Published var pictureData = Data(count: 0)
    
    func checkAuthorization() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setup()
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { (finished) in
                if finished {
                    self.setup()
                }
            }
        case .denied:
            self.alert.toggle()
        default: return
        }
    }
    
    func setup() {
//        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes:
//                    [.builtInTrueDepthCamera, .builtInDualCamera, .builtInWideAngleCamera, .builtInDualWideCamera, .builtInTripleCamera, .builtInTelephotoCamera, .builtInUltraWideCamera],
//                mediaType: .video, position: .back)
//
//        let devices = discoverySession.devices
//        guard !devices.isEmpty else { fatalError("Missing capture devices.")}
//
//        devices.forEach({
//           print($0.deviceType)
//        })
        
        
        do {
            session.beginConfiguration()
            
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            let input = try AVCaptureDeviceInput(device: device!)
            
            if session.canAddInput(input) {
                session.addInput(input)
            }
            
            if session.canAddOutput(output) {
                session.addOutput(output)
            }
            
            session.commitConfiguration()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func takePickture() {
        
        DispatchQueue.global(qos: .background).async {
            self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
            self.session.stopRunning()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
            }
        }
        
    }
    
    func reTakePickture() {
        
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation {
                    self.isTaken.toggle()
                }
                
                self.isSaved = false
            }
        }
        
    }
    
    func savePicture() {
        let image = UIImage(data: pictureData)
        UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
        
        isSaved = true
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let err = error {
            print(err.localizedDescription)
            return
        }
        
        guard let data = photo.fileDataRepresentation() else { return }
        self.pictureData = data
    }

}

struct CameraPreview: UIViewRepresentable {
    
    @ObservedObject var camera: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView(frame: UIScreen.main.bounds)
        camera.preview = AVCaptureVideoPreviewLayer(session: camera.session)
        camera.preview.frame = view.frame
        camera.preview.videoGravity = .resizeAspectFill
        
        view.layer.addSublayer(camera.preview)
        
        camera.session.startRunning()
        
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
