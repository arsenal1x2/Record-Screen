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
        
    }
    
    func startRecordingNoMicrophone(withFileName filename: String, recordingHandler:@escaping (Error?)-> Void) {
        
    }
}
