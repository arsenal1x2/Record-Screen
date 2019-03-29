//
//  ScreenRecorder.swift
//  RecordScreen
//
//  Created by LTT on 253//19.
//  Copyright © 2019 LTT. All rights reserved.
//
import AVFoundation
import ReplayKit

class ScreenRecorder {
    static let shared = ScreenRecorder ()
    var assetWriter: AVAssetWriter!
    var videoInput: AVAssetWriterInput!
    var audioAppInput: AVAssetWriterInput!
    var audioMicInput: AVAssetWriterInput!
    var isMicrophoneEnabled: Bool = RPScreenRecorder.shared().isMicrophoneEnabled {
        didSet {
            RPScreenRecorder.shared().isMicrophoneEnabled = isMicrophoneEnabled
        }
    }
    var isRecording: Bool {
        return RPScreenRecorder.shared().isRecording
    }
    
    func initFile(filename: String) {
        let fileURL = URL(fileURLWithPath: ReplayFileUtil.filePath(filename))
        assetWriter = try! AVAssetWriter(outputURL: fileURL, fileType:
            AVFileType.mp4)
    }
    
    func configVideoInput() {
        let videoOutputSettings: Dictionary<String, Any> = [
            AVVideoCodecKey : AVVideoCodecType.h264,
            AVVideoWidthKey : UIScreen.main.bounds.size.width,
            AVVideoHeightKey : UIScreen.main.bounds.size.height
        ]
        videoInput  = AVAssetWriterInput (mediaType: AVMediaType.video, outputSettings: videoOutputSettings)
        videoInput.expectsMediaDataInRealTime = true
        assetWriter.add(videoInput)
    }
    
    func configAudioMicrophoneInput() {
        let audioOutputSettings: Dictionary<String, Any> = [
            AVFormatIDKey : kAudioFormatMPEG4AAC,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0,
            AVEncoderBitRateKey: 192000
        ]
        audioMicInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: audioOutputSettings)
        audioMicInput.expectsMediaDataInRealTime = true
        assetWriter.add(audioMicInput)
        
    }
    
    func configAudioAppInput() {
        let audioOutputSettings: Dictionary<String, Any> = [
            AVFormatIDKey : kAudioFormatMPEG4AAC,
            AVNumberOfChannelsKey : 2,
            AVSampleRateKey : 44100.0,
            AVEncoderBitRateKey: 192000
        ]
        audioAppInput = AVAssetWriterInput(mediaType: AVMediaType.audio, outputSettings: audioOutputSettings)
        audioAppInput.expectsMediaDataInRealTime = true
        assetWriter.add(audioAppInput)
    }
    
    
    func startRecordingWithMicrophone(withFileName filename: String, recordingHandler:@escaping (Error?)-> Void) {
        initFile(filename: filename)
        configVideoInput()
        configAudioAppInput()
        configAudioMicrophoneInput()
        RPScreenRecorder.shared().startCapture(handler: { (buffer, bufferType, error) in
            recordingHandler(error)
            if CMSampleBufferDataIsReady(buffer) {
                if self.assetWriter.status == AVAssetWriterStatus.unknown {
                    self.assetWriter.startWriting()
                    self.assetWriter.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(buffer))
                }
                
                if self.assetWriter.status == AVAssetWriterStatus.failed {
                    print("Error occured, status = \(self.assetWriter.status.rawValue), \(self.assetWriter.error!.localizedDescription) \(String(describing: self.assetWriter.error))")
                    return
                }
                
                if bufferType == .video {
                    if self.videoInput.isReadyForMoreMediaData {
                        self.videoInput.append(buffer)
                    }
                }
                if bufferType == .audioApp {
                    if self.audioAppInput.isReadyForMoreMediaData {
                        self.audioAppInput.append(buffer)
                    }
                }
                if bufferType == .audioMic {
                    if self.audioMicInput.isReadyForMoreMediaData {
                        self.audioMicInput.append(buffer)
                    }
                }
            }
        }) { (error) in
            recordingHandler(error)
        }
    }
    
    func startRecordingNoMicrophone(withFileName filename: String, recordingHandler:@escaping (Error?)-> Void) {
        initFile(filename: filename)
        configVideoInput()
        configAudioAppInput()
        RPScreenRecorder.shared().startCapture(handler: { (buffer, bufferType, error) in
            recordingHandler(error)
            if CMSampleBufferDataIsReady(buffer) {
                if self.assetWriter.status == AVAssetWriterStatus.unknown {
                    self.assetWriter.startWriting()
                    self.assetWriter.startSession(atSourceTime: CMSampleBufferGetPresentationTimeStamp(buffer))
                }
                
                if self.assetWriter.status == AVAssetWriterStatus.failed {
                    print("Error occured, status = \(self.assetWriter.status.rawValue), \(self.assetWriter.error!.localizedDescription) \(String(describing: self.assetWriter.error))")
                    return
                }
                
                if bufferType == .video {
                    if self.videoInput.isReadyForMoreMediaData {
                        self.videoInput.append(buffer)
                    }
                }
                
                if bufferType == .audioApp {
                    if self.audioAppInput.isReadyForMoreMediaData {
                        self.audioAppInput.append(buffer)
                    }
                }
            }
        }) { (error) in
            recordingHandler(error)
        }
    }
    
    func stopRecording(handler: @escaping (Error?) -> Void) {
            RPScreenRecorder.shared().stopCapture {    (error) in
                    handler(error)
                    self.assetWriter.finishWriting {
                        
                    }
            }
    }
}
