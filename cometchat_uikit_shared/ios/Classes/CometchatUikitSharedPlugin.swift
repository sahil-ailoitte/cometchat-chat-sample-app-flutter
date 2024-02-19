import Flutter
import UIKit
import Foundation
import AVFoundation
import CoreLocation
import QuickLook
import MobileCoreServices
// For iOS 14+
import UniformTypeIdentifiers


enum Sound {
    case incomingCall
    case incomingMessage
    case incomingMessageForOther
    case outgoingCall
    case outgoingMessage
}

public var audioPlayer: AVAudioPlayer?
var otherAudioPlaying = AVAudioSession.sharedInstance().isOtherAudioPlaying
var globalRegistrar: FlutterPluginRegistrar?
var docController : UIDocumentInteractionController?
var viewController :  UIViewController?
var globalResult:  FlutterResult?

public class CometchatUikitSharedPlugin: NSObject, FlutterPlugin , CLLocationManagerDelegate , QLPreviewControllerDataSource, QLPreviewControllerDelegate,UIDocumentPickerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    
    lazy var previewItem = NSURL()
    static var curentLocation: CLLocation?
    static var locationManager = CLLocationManager()
    static var interactionController: UIDocumentInteractionController?
    static var uiViewController: UIViewController?
    var  documentPicker: UIDocumentPickerViewController = UIDocumentPickerViewController(documentTypes: ["public.data","public.content","public.audiovisual-content","public.movie","public.audiovisual-content","public.video","public.audio","public.data","public.zip-archive","com.pkware.zip-archive","public.composite-content","public.text"], in: UIDocumentPickerMode.import)
    var imagePicker = UIImagePickerController()
    
    var filePickerResult:  FlutterResult?
    
    
    
    
    
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "cometchat_uikit_shared", binaryMessenger: registrar.messenger())
        let viewController = UIApplication.shared.delegate?.window?!.rootViewController
        let instance = CometchatUikitSharedPlugin(viewController: viewController)
        registrar.addMethodCallDelegate(instance, channel: channel)
        globalRegistrar = registrar
        CometchatUikitSharedPlugin.locationManager.distanceFilter = kCLDistanceFilterNone
        CometchatUikitSharedPlugin.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = instance
        
    }
    
    init(viewController: UIViewController?) {
        super.init()
        CometchatUikitSharedPlugin.uiViewController = viewController
        documentPicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.mediaTypes = ["public.image", "public.movie"]
        
        
    }
    
    
    
    
    /// Invoked when the Quick Look preview controller needs to know the number of preview items to include in the preview navigation list.
    /// - Parameter controller: A specialized view for previewing an item.
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int { return 1 }
    
    
    /// Invoked when the Quick Look preview controller needs the preview item for a specified index position.
    /// - Parameters:
    ///   - controller: A specialized view for previewing an item.
    ///   - index: The index position, within the preview navigation list, of the item to preview.
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
    
    
    /// This method triggers when we open document menu to send the message of type `File`.
    /// - Parameters:
    ///   - controller: A view controller that provides access to documents or destinations outside your app’s sandbox.
    ///   - urls: A value that identifies the location of a resource, such as an item on a remote server or the path to a local file.
    public func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            print("Passed are")
            print(urls)
            var resultDict = [Dictionary<String,String?>]()
            for url in urls{
                
                let path: String = url.path
                if let index = path.lastIndex(of: "/") {
                    let name = String(path.suffix(from: index).dropFirst())
                    
                    
                    let indvFile:  Dictionary<String,String?> = ["path": path ,
                                                                 "name": name]
                    resultDict.append(indvFile)
                    
                }
                
                
            }
            
            guard let pickResult = filePickerResult else{
                return
            }
            pickResult(resultDict)
            
            
        }
    }
    
    
    
    func createTemporaryURLforVideoFile(url: NSURL) -> NSURL {
        /// Create the temporary directory.
        let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        /// create a temporary file for us to copy the video to.
        let temporaryFileURL = temporaryDirectoryURL.appendingPathComponent(url.lastPathComponent ?? "")
        /// Attempt the copy.
        do {
            try FileManager().copyItem(at: url.absoluteURL!, to: temporaryFileURL)
        } catch {
            print("There was an error copying the video file to the temporary location.")
        }
        
        return temporaryFileURL as NSURL
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info:[UIImagePickerController.InfoKey : Any]) {
        var resultDict = [Dictionary<String,String?>]()
        var indvFile:  Dictionary<String,String?>? = nil
        
        
        if let  videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? NSURL {
            
            guard let url = videoURL.path else{
                return
            }
            
            var newUrl = createTemporaryURLforVideoFile(url:videoURL )
            
            if let index = url.lastIndex(of: "/") {
                let name = String(url.suffix(from: index).dropFirst())
                print(name)
                
                indvFile = ["path": newUrl.absoluteString , "name": name]
                
            }
        }
        
        
        
        if #available(iOS 11.0, *) {
            if let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? NSURL {
                
                guard let url = imageURL.path else{
                    return
                }
                
                
                if let index = url.lastIndex(of: "/") {
                    let name = String(url.suffix(from: index).dropFirst())
                    print(name)
                    
                    indvFile = ["path": imageURL.absoluteString , "name": name]
                    
                }
                
            }
            
        }else{
            imagePicker.dismiss(animated: true, completion: nil)
            cleanResult()
            return
        }
        
        
        
        
        resultDict.append(indvFile!)
        guard let pickResult = filePickerResult else{
            return
        }
        pickResult(resultDict)
        
        
        imagePicker.dismiss(animated: true, completion: nil)
        cleanResult()
        
    }
    
    
    
    
    private func presentQuickLook() {
        DispatchQueue.main.async { [weak self] in
            let previewController = QLPreviewController()
            previewController.modalPresentationStyle = .popover
            previewController.dataSource = self
            previewController.navigationController?.title = ""
            
            if let controller = CometchatUikitSharedPlugin.uiViewController {
                controller.present(previewController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    private func presentDocumentPicker() {
        DispatchQueue.main.async { [weak self] in
            
            guard let this = self else{
                return
            }
            
            if let controller = CometchatUikitSharedPlugin.uiViewController {
                this.documentPicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                controller.present(this.documentPicker, animated: true, completion: nil)
            }
        }
    }
    
    
    private func presentImagePicker() {
        
        
        DispatchQueue.main.async { [weak self] in
            
            guard let this = self else{
                return
            }
            
            if let controller = CometchatUikitSharedPlugin.uiViewController {
                this.imagePicker.modalPresentationStyle = UIModalPresentationStyle.fullScreen
                if #available(iOS 11.0, *) {
                    this.imagePicker.videoExportPreset = AVAssetExportPresetPassthrough
                } else {
                    // Fallback on earlier versions
                }
                
                controller.present(this.imagePicker, animated: true, completion: nil)
            }
        }
    }
    
    
    private func cleanResult(){
        self.filePickerResult = nil
    }
    
    
    
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        let args = call.arguments as? [String: Any] ?? [String: Any]();
        switch call.method {
        case "playCustomSound":
            self.playCustomSound(args: args, result:result)
        case "getAddress":
            self.getAddress(args: args, result:result)
        case "stopPlayer":
            self.stopPlayer(args: args, result:result)
        case "open_file":
            self.openFile(args: args, result:result)
        case "getLocationPermission":
            self.checkPermission(args: args, result:result)
        case "getCurrentLocation":
            self.getLocation(args: args, result:result)
        case "pickFile":
            self.pickFile(args: args, result:result)
        case "shareMessage":
            self.didSharePressed(args: args, result:result)
        case "startRecordingAudio":
            self.startRecordingAudio(args: args, result:result)
        case "stopRecordingAudio":
            self.stopRecordingAudio(args: args, result:result)
        case "deleteFile":
            self.deleteFile(args: args, result:result)
        case "playRecordedAudio":
            self.playRecordedAudio(args: args, result: result)
        case "pausePlayingRecordedAudio":
            self.pausePlayingRecordedAudio(args: args, result: result)
        case "releaseAudioRecorderResources":
            self.releaseAudioRecorderResources(args: args, result: result)
        case "download":
            self.download(args: args, result:result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
    
    
    
    private func playCustomSound(args: [String: Any], result: @escaping FlutterResult){
        
        let audioType = args["assetAudioPath"] as? String
        let package = args["package"] as? String
        var assetKey:String?
        
        if(package != nil){
            assetKey = globalRegistrar?.lookupKey(forAsset: audioType! , fromPackage: package! )
        }else{
            assetKey = globalRegistrar?.lookupKey(forAsset: audioType! )
        }
        
        
        guard let path = Bundle.main.path(forResource: assetKey, ofType: nil) else {
            result("");
            return
        }
        let url = URL(fileURLWithPath: path)
        
        return playSound(url: url, result: result)
        
        
    }
    
    
    private func pickFile(args: [String: Any], result: @escaping FlutterResult){
        
        let type = args["type"] as! String
        
        if(self.filePickerResult != nil){
            self.filePickerResult = nil
        }
        self.filePickerResult = result
        
        if(type ==  "imagevideo"){
            presentImagePicker()
            return
        }else{
            presentDocumentPicker()
            return
        }
        
        
        
    }
    
    
    
    
    private func playSound(url:URL, result: @escaping FlutterResult)  {
        
        let otherAudioPlaying = AVAudioSession.sharedInstance().secondaryAudioShouldBeSilencedHint
        if otherAudioPlaying {
            AudioServicesPlayAlertSound(SystemSoundID(1519))
            result("VIBRATION")
            return
        }
        
        
        do {
            
            if(audioPlayer != nil && audioPlayer?.isPlaying==true){
                audioPlayer?.stop()
            }
            
            
            /* set session category and mode with options */
            if #available(iOS 10.0, *) {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, mode: AVAudioSession.Mode.default, options: [])
            } else {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: .mixWithOthers)
            }
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.soloAmbient)
            
            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            
            
            
            
            print(" line 137")
            result("Error");
            
            
            
        } catch _ {
            result("Error")
        }
        
        
    }
    
    func toInt(duration : Double) -> Int? {
        if duration >= Double(Int.min) && duration < Double(Int.max) {
            return Int(duration)
        } else {
            return nil
        }
    }
    
    public func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("Finished")
        //result("Success")//It is working now! printed "finished"!
    }
    
    
    private func playUrl(args: [String: Any], result: @escaping FlutterResult){
        let audioURL = args["audioURL"] as? String
        print("audio uRL is \(String(describing: audioURL)) ")
        
        guard let url = URL(string: audioURL ?? "")
        else{
            print("error to get the mp3 file")
            return
        }
        
        let newUrl: URL = URL(fileURLWithPath: audioURL ?? "")
        
        
        playSound(url: newUrl, result: result)
        
        
    }
    
    
    
    private func stopPlayer(args: [String: Any], result: @escaping FlutterResult){
        
        if(audioPlayer != nil && audioPlayer!.isPlaying ){
            audioPlayer?.stop();
            
        }
        
    }
    
    
    private func getAddress(args: [String: Any], result: @escaping FlutterResult){
        let latitude = args["latitude"] as? Double
        let longitude = args["longitude"] as? Double
        
        
        let geoCoder = CLGeocoder()
        if(latitude != nil){
            let location = CLLocation(latitude: latitude! , longitude: longitude!)
            geoCoder.reverseGeocodeLocation(location)  { (placemarks, error) -> Void in
                
                var placeMark: CLPlacemark!
                placeMark = placemarks?[0]
                
                let address = "\(placeMark?.name ?? ""),,\(placeMark?.subLocality ?? "") \(placeMark?.thoroughfare ?? ""),, \(placeMark?.locality ?? ""),, \(placeMark?.subLocality ?? ""),, \(placeMark?.administrativeArea ?? ""),, \(placeMark?.postalCode ?? ""),, \(placeMark?.country ?? "")"
                print("address is \(address)")
                
                
                result(self.getAddressMap(placeMarks: placeMark ))
            }
            
            
        }
        
        
        
        
    }
    
    
    
    private func getAddressMap(placeMarks: CLPlacemark, methodName: String = "") -> [String: Any]? {
        var placeMap = [
            "country" : placeMarks.country,
            "city" :  placeMarks.thoroughfare,
            "state" : placeMarks.locality,
            "adminArea" : placeMarks.administrativeArea,
            "postalCode" : placeMarks.postalCode,
            "addressLine" : placeMarks.subLocality,
        ]
        
        return placeMap
    }
    
    
    private func openFile(args: [String: Any], result: @escaping FlutterResult){
        let filePath = args["file_path"] as? String
        self.previewItem = URL(fileURLWithPath: filePath!) as NSURL
        self.presentQuickLook()
        
    }
    
    func getAuthorization(_ completion: () -> ()) {
        CometchatUikitSharedPlugin.locationManager.requestWhenInUseAuthorization()
        completion()
    }
    
    
    private func checkPermission(args: [String: Any], result: @escaping FlutterResult)  {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            CometchatUikitSharedPlugin.curentLocation = CometchatUikitSharedPlugin.locationManager.location
            var resultMap = [[String:Any]]()
            resultMap.append(["status": true])
            result(resultMap)
        } else {
            globalResult = result
            
            getAuthorization({
                print("Task finished.")
            })
        }
    }
    
    
    private func getLocation(args: [String: Any], result: @escaping FlutterResult){
        CometchatUikitSharedPlugin.curentLocation = CometchatUikitSharedPlugin.locationManager.location
        var locationMap = [
            "latitude" : CometchatUikitSharedPlugin.curentLocation?.coordinate.latitude ?? 0 as Any,
            "longitude" : CometchatUikitSharedPlugin.curentLocation?.coordinate.longitude ?? 0  as Any,
        ]
        result(locationMap)
        print(CometchatUikitSharedPlugin.curentLocation?.coordinate.latitude ?? 0)
        
        
    }
    
    
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus){
        
        if (status == CLAuthorizationStatus.denied) {
            // The user denied authorization
        } else if (status == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
        }
    }
    
    @available(iOS 14.0, *)
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if(globalResult != nil){
            
            if(manager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse){
                globalResult?(["status": true]);
            }else{
                globalResult?(["status": false]);
            }
            
            
        }
        
        
    }
    
    
    private func didSharePressed(args: [String: Any], result: @escaping FlutterResult) {
        let message = args["message"];
        let type = args["type"] as? String;
        let mediaName = args["mediaName"]; // get File name
        let fileUrl = args["fileUrl"] as? String; // get File url
        let mimeType = args["mimeType"]; // get Mime Type
        let subType = args["subtype"] as? String; // get Mime Type
        
        
        if type == "text" {
            
            let textToShare = message as! String
            copyMedia(textToShare)
            
        }else if subType == "audio" || subType == "file" || subType == "image" || subType == "video" {
            
            if let fileUrl = fileUrl {
                let url = URL(string: fileUrl ?? "")
                guard let url = url else {
                    print("Url is empty")
                    return
                }
                self.downloadMediaMessage(url: url, completion: {fileLocation in
                    if let fileLocation = fileLocation {
                        self.copyMedia(fileLocation)
                    }
                })
            }
            
        }
    }
    
    func downloadMediaMessage(url: URL, completion: @escaping (_ fileLocation: URL?) -> Void){
        
        let documentsDirectoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let destinationUrl = documentsDirectoryURL.appendingPathComponent(url.lastPathComponent ?? "")
        if FileManager.default.fileExists(atPath: destinationUrl.path) {
            completion(destinationUrl)
        } else {
            // CometChatSnackBoard.show(message: "Downloading...")
            URLSession.shared.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                guard let tempLocation = location, error == nil else { return }
                do {
                    // CometChatSnackBoard.hide()
                    try FileManager.default.moveItem(at: tempLocation, to: destinationUrl)
                    completion(destinationUrl)
                } catch let error as NSError {
                    completion(nil)
                }
            }).resume()
        }
    }
    
    func copyMedia(_ item: Any) {
        if let controller = CometchatUikitSharedPlugin.uiViewController {
            let activityViewController = UIActivityViewController(activityItems: [item], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = controller.view
            activityViewController.excludedActivityTypes = [.airDrop]
            
            
            
            DispatchQueue.main.async {
                controller.present(activityViewController, animated: true, completion: nil)
            }
            
        }
    }
    
    private var audioRecorder: AudioRecorder?
    private func startRecordingAudio(args: [String: Any], result: @escaping FlutterResult){
        audioRecorder = AudioRecorder(binaryMessenger: (globalRegistrar?.messenger())!)
        audioRecorder?.setupRecorder(result: result)
    }
    
    private func stopRecordingAudio(args: [String: Any], result: @escaping FlutterResult){
        if audioRecorder != nil {
            let path = audioRecorder?.stopRecording(success: true)
            
            result(path)
            
        }
        
    }
    
    private func playRecordedAudio(args: [String: Any], result: @escaping FlutterResult){
        if audioRecorder != nil {
            audioRecorder?.startPlaying()
        }
        
    }
    private func pausePlayingRecordedAudio(args: [String: Any], result: @escaping FlutterResult){
        if audioRecorder != nil {
            audioRecorder?.pausePlaying()
        }
        
    }
    
    private func deleteFile(args: [String: Any], result: @escaping FlutterResult) {
        let filePath = args["filePath"] as? String
        
        if filePath == nil {
            result(FlutterError(code: "Invalid Arguments",
                                message: "filePath cannot be null",
                                details: nil))
        } else {
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(atPath: filePath!)
                result(true)
            } catch {
                print("Error deleting file: \(error)")
                result(false)
            }
        }
        
    }
    
    private func releaseAudioRecorderResources(args: [String: Any], result: @escaping FlutterResult){
        if audioRecorder != nil {
            audioRecorder?.releaseMediaResources()
            audioRecorder = nil
        }
    }
    
    private func download(args: [String: Any], result: @escaping FlutterResult){
    
        let fileUrl = args["fileUrl"] as? String; // get File url
       
        
        if let fileUrl = fileUrl {
            let url = URL(string: fileUrl ?? "")
            guard let url = url else {
                print("Url is empty")
                return
            }
            self.downloadMediaMessage(url: url, completion: {fileLocation in
                if let fileLocation = fileLocation {
                    self.copyMedia(fileLocation)
                }
            })
        }
    }
    
}

