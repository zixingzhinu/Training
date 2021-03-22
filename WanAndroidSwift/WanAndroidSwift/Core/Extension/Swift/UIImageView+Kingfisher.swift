//
//  UIImageView+Kingfisher.swift
//  WanAndroidSwift
//
//  Created by James on 2021/3/15.
//

import UIKit
import Kingfisher

/// Kingfisher扩展
extension UIImageView {
    
    /// 标准设置图片方法
    /// - Parameter urlString: url
    func vSetImage(_ urlString: String) {
        let processor = DownsamplingImageProcessor(size: self.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 2)
        self.kf.indicatorType = .activity
        guard let url = URL(string: urlString) else {
            printDebug("无图片", urlString)
            return
        }
        let options: KingfisherOptionsInfo = [
            /// 在使用之前在后台线程解码图像
            .backgroundDecode,
            /// 动画图像只读第一帧，如果目标图像不是动画图像数据，则将忽略此选项。
            .onlyLoadFirstFrame,
            /// 下载完成时,处理器会将下载的数据转换为一个图像。如果缓存连接到下载器(当你正在使用KingfisherManager或图像扩展方法),转换后的图像也将被缓存,比如后期滤镜,如果未设置，则将使用`DefaultImageProcessor.default`。
            .processor(processor),
            ///如果设置，则磁盘存储加载将在同一调用队列中进行。默认情况下，磁盘存储文件加载以异步调度行为在其自己的队列中进行。尽管它提供了更好的非阻塞磁盘加载性能，但是如果从磁盘重新加载图像（如果图像视图已经设置了图像），它也会引起闪烁。
            ///设置此选项将所有负载保持在同一队列中（如果使用Kingfisher的扩展方法来设置图片，通常是UI队列）将停止闪烁，并在加载性能方面进行权衡。
            .loadDiskFileSynchronously,
            /// 将检索到的图片数据转换成一个图时 这个成员变量将被用作图片缩放因子。图像分辨率,而不是屏幕尺寸。你可能处理时需要指定正确的缩放因子@2x或@3x Retina图像。
            .scaleFactor(UIScreen.main.scale),
            /// 网络下载时设置过渡动画
            .transition(.fade(1)),
            ///如果设置并且使用了`ImageProcessor`，Kingfisher将尝试缓存最终结果和原始图像。当将另一个处理器应用于相同资源时，翠鸟将有机会使用原始图像，而无需再次下载。必要时，您可以使用.originalCache`来指定缓存或原始图像。
            ///原始映像将仅缓存到磁盘存储中。
            .cacheOriginalImage]
        self.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder_banner"), options: options, completionHandler: nil)
//        KF.url(url)
//            .placeholder(#imageLiteral(resourceName: "placeholder_banner"))
//            .setProcessor(processor)
//            .loadDiskFileSynchronously()
//            .cacheMemoryOnly()
//            .fade(duration: 0.25)
//            .set(to: self)
    }
    
    ///  图片缓存大小计算
    func vGetImageCacheSize( _ block: @escaping (String) -> () ) {
        let cache = ImageCache.default
        cache.diskStorage.config.sizeLimit = UInt(200 * 1024 * 1024)
        cache.diskStorage.config.expiration = .days(15)

        //清除过期缓存
        cache.calculateDiskStorageSize { result in
            switch result {
            case .success(let size):

                var dataSize : String{
                    guard size >= 1024 else { return "\(size) bytes" }
                    guard size >= 1048576 else { return "\(size / 1024) KB" }
                    guard size >= 1073741824 else { return "\(size / 1048576) MB" }
                    return "\(size / 1073741824) GB"
                }
                block(dataSize)
            case .failure(let error):
                debugPrint("统计图片缓存失败", error)
            }
        }
        
    }
    
    /// 设置图片缓存大小
    func vSetImageCache(){
        let downloader = ImageDownloader.default

        downloader.downloadTimeout = 15 //默认15秒下载超时
        
        let cache = ImageCache.default

    //    cache.maxMemoryCost = 30 * 1024 * 1024
        // 设置最大内存使用量，有可能造成图片下载不完全（待确认）

        cache.diskStorage.config.sizeLimit = UInt(200 * 1024 * 1024) //200M 的缓存空间

        cache.diskStorage.config.expiration = .days(15)  // 15天过期时间 默认是1星期
        //需要手动清理过期缓存
        cache.cleanExpiredDiskCache()
    }
}
