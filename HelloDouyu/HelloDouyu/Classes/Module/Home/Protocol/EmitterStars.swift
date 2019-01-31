//
//  EmitterStars.swift
//  HelloDouyu
//
//  Created by James on 2019/1/26.
//  Copyright © 2019 FinupCredit. All rights reserved.
//

import Foundation
import UIKit

protocol Stars {
}

/**
 /** `emitterShape' values.发射器形状的值 **/
 
 CA_EXTERN NSString * const kCAEmitterLayerPoint//发射器为点。
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerLine//发射器为线状。
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerRectangle//发射器为矩形、
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerCuboid//发射器为立方体。
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerCircle//发射器为圆形。
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerSphere//发射器为球形。
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 
 /** `emitterMode' values. 发射器模式的值**/
 
 CA_EXTERN NSString * const kCAEmitterLayerPoints//发射器XY平面中心点发出
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerOutline//发射器边缘发出
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerSurface//发射器表面发出
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerVolume//发射器立体中心点发出
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 
 /** `renderMode' values. 渲染模式的值**/
 
 CA_EXTERN NSString * const kCAEmitterLayerUnordered //粒子无序出现，多个发射源将混合
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerOldestFirst//声明久的粒子会被渲染在最上层
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerOldestLast//最新发射的粒子会被渲染在最上层
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerBackToFront//粒子的渲染按照Z轴的前后顺序进行
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 CA_EXTERN NSString * const kCAEmitterLayerAdditive//进行粒子混合
 CA_AVAILABLE_STARTING (10.6, 5.0, 9.0, 2.0);
 */
extension Stars where Self: UIView {
    
    func createStarsWithSelf() {
        let emitterLayer = layer as! CAEmitterLayer
        _createEmitter(emitterLayer: emitterLayer)
    }
    
    func createStarsInSelf() {
        let emitterLayer = layer as! CAEmitterLayer
        _createEmitter(emitterLayer: emitterLayer)
        layer.addSublayer(emitterLayer)
    }
    
    func createEmitterLayer() -> CAEmitterLayer {
        let emitterLayer = CAEmitterLayer()
        _createEmitter(emitterLayer: emitterLayer)
        return emitterLayer
    }
    
    private func _createEmitter(emitterLayer: CAEmitterLayer) {
        /* 产生的速度，即每秒发射出的粒子数量。 */
        //        emitterLayer.birthRate = 1
        /*粒子的存活时间*/
        //        emitterLayer.lifetime = 1
        
        /*发射器在XY平面的发射位置*/
        emitterLayer.emitterPosition = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        print("emitterPosition=\(bounds), \(bounds.width), \(bounds.height)")
        /*发射器在Z平面的位置  */
        //        emitterLayer.emitterZPosition = 1
        
        /*粒子发射器尺寸大小*/
        emitterLayer.emitterSize = CGSize(width: 150, height: 150)
        /* 发射器深度，在某些模式下会产生立体效果 */
        //        emitterLayer.emitterDepth = 0
        
        /* 发射器的形状。选项有point（默认）、line、rectangle、circle、cuboid、sphere。*/
        //        emitterLayer.emitterShape = CAEmitterLayerEmitterShape.circle
        /*发射模式。选项有points、outline、surface、volume（默认）。*/
        //        emitterLayer.emitterMode = CAEmitterLayerEmitterMode.outline
        /*发射器渲染模式。*/
        //        emitterLayer.renderMode = CAEmitterLayerRenderMode.additive
        
        /*是否开启三维空间效果。默认是NO。如果设置为true，filters、backgroundFilters的效果和图层的阴影相关的属性是不明确的。*/
        //        emitterLayer.preservesDepth = true
        /*粒子的运动速度。*/
        //        emitterLayer.velocity = 1
        /*粒子的缩放大小。*/
        //        emitterLayer.scale = 1
        /*  粒子的旋转位置。 */
        //        emitterLayer.spin = 1
        /* 初始化随机的粒子种子。默认是0。*/
        //        emitterLayer.seed = 0
        
        
        let emitterCell = CAEmitterCell()
        /*粒子名字，用来构造键值粒子，与setValue:forKeyPath：搭配使用。默认是nil。*/
        //        emitterCell.name = nil
        /*是否允许发射器的粒子被渲染*/
        //        emitterCell.isEnabled = true
        /* 产生的速度，即每秒发射出的粒子数量。 */
        emitterCell.birthRate = 10
        
        /* 粒子的存活时间*/
        emitterCell.lifetime = 3
        /*粒子的生存时间容差,即存活时间偏差范围 */
        emitterCell.lifetimeRange = 1.5
        
        /*粒子在Z轴方向的发射角度*/
        //        emitterCell.emissionLatitude = 0
        /*粒子在XY平面的发射角度*/
        //        emitterCell.emissionLongitude = -.pi / 2
        /*粒子发射角度的容差，即角度变化范围。默认是0.*/
        //        emitterCell.emissionRange = .pi / 2
        
        /*粒子的速度*/
        emitterCell.velocity = 100
        /*粒子的速度容差*/
        emitterCell.velocityRange = 50
        
        /*粒子在x、y、z三个方向的加速度*/
        //        emitterCell.xAcceleration = 0
        //        emitterCell.yAcceleration = 0
        //        emitterCell.zAcceleration = 1
        
        /*粒子的缩放大小、缩放容差、缩放速度*/
        emitterCell.scale = 0.5
        emitterCell.scaleRange = 0.25
        //        emitterCell.scaleSpeed = 1
        
        /*粒子的旋转度、旋转容差*/
        //        emitterCell.spin = 1
        //        emitterCell.spinRange = 0.5
        
        /*粒子颜色*/
        emitterCell.color = UIColor.randomColor().cgColor
        
        /*粒子在R、G、B色相上的容差和透明度*/
        //        emitterCell.redRange = 0
        //        emitterCell.greenRange = 0
        //        emitterCell.blueRange = 0
        //        emitterCell.alphaRange = 0
        
        /*粒子在R、G、B色相上的变化速度和透明度的变化速度*/
        //        emitterCell.redSpeed = 0
        //        emitterCell.greenSpeed = 0
        //        emitterCell.blueSpeed = 0
        //        emitterCell.alphaSpeed = 0
        
        /*粒子展示内容，一般用来设置图片。默认为nil。 */
        emitterCell.contents = UIImage(named: "good6_30x30")?.cgImage
        /*粒子展示内容的尺寸大小*/
        //        emitterCell.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 1)
        /*粒子展示内容的缩放比例*/
        //        emitterCell.contentsScale = 1
        
        /*渲染内容图像用的滤波器参数*/
        //        emitterCell.minificationFilter = CALayerContentsFilter.linear.rawValue
        //        emitterCell.magnificationFilter = CALayerContentsFilter.linear.rawValue
        //        emitterCell.minificationFilterBias = 0
        
        /*粒子数组*/
        //        emitterCell.emitterCells = nil
        /* 继承自类似于图层上的属性 */
        //        emitterCell.style = nil
        
        /* 存放添加到发射图层上的粒子数组。 */
        emitterLayer.emitterCells = [emitterCell]
    }
}

