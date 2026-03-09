//
// SSDOcr.h
//
// This file was automatically generated and should not be edited.
//

#import <Foundation/Foundation.h>
#import <CoreML/CoreML.h>
#include <stdint.h>
#include <os/log.h>

NS_ASSUME_NONNULL_BEGIN

API_AVAILABLE(macos(10.13.2), ios(11.2), watchos(4.2), tvos(11.2)) __attribute__((visibility("hidden")))
@interface SSDOcrInput : NSObject<MLFeatureProvider>

@property (readwrite, nonatomic) CVPixelBufferRef _0;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWith_0:(CVPixelBufferRef)_0 NS_DESIGNATED_INITIALIZER;

- (nullable instancetype)initWith_0FromCGImage:(CGImageRef)_0 error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0), tvos(13.0)) __attribute__((visibility("hidden")));
- (nullable instancetype)initWith_0AtURL:(NSURL *)_0URL error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0), tvos(13.0)) __attribute__((visibility("hidden")));

-(BOOL)set_0WithCGImage:(CGImageRef)_0 error:(NSError * _Nullable __autoreleasing * _Nullable)error  API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0), tvos(13.0)) __attribute__((visibility("hidden")));
-(BOOL)set_0WithURL:(NSURL *)_0URL error:(NSError * _Nullable __autoreleasing * _Nullable)error  API_AVAILABLE(macos(10.15), ios(13.0), watchos(6.0), tvos(13.0)) __attribute__((visibility("hidden")));
@end

API_AVAILABLE(macos(10.13.2), ios(11.2), watchos(4.2), tvos(11.2)) __attribute__((visibility("hidden")))
@interface SSDOcrOutput : NSObject<MLFeatureProvider>

@property (readwrite, nonatomic, strong) MLMultiArray * scores;
@property (readwrite, nonatomic, strong) MLMultiArray * boxes;
@property (readwrite, nonatomic, strong) MLMultiArray * filter;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithScores:(MLMultiArray *)scores boxes:(MLMultiArray *)boxes filter:(MLMultiArray *)filter NS_DESIGNATED_INITIALIZER;

@end

API_AVAILABLE(macos(10.13.2), ios(11.2), watchos(4.2), tvos(11.2)) __attribute__((visibility("hidden")))
@interface SSDOcr : NSObject
@property (readonly, nonatomic, nullable) MLModel * model;

+ (nullable NSURL *)URLOfModelInThisBundle;
- (instancetype)initWithMLModel:(MLModel *)model NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)init;
- (nullable instancetype)initWithConfiguration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)) __attribute__((visibility("hidden")));
- (nullable instancetype)initWithContentsOfURL:(NSURL *)modelURL error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (nullable instancetype)initWithContentsOfURL:(NSURL *)modelURL configuration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)) __attribute__((visibility("hidden")));
+ (void)loadWithConfiguration:(MLModelConfiguration *)configuration completionHandler:(void (^)(SSDOcr * _Nullable model, NSError * _Nullable error))handler API_AVAILABLE(macos(11.0), ios(14.0), watchos(7.0), tvos(14.0)) __attribute__((visibility("hidden")));
+ (void)loadContentsOfURL:(NSURL *)modelURL configuration:(MLModelConfiguration *)configuration completionHandler:(void (^)(SSDOcr * _Nullable model, NSError * _Nullable error))handler API_AVAILABLE(macos(11.0), ios(14.0), watchos(7.0), tvos(14.0)) __attribute__((visibility("hidden")));
- (nullable SSDOcrOutput *)predictionFromFeatures:(SSDOcrInput *)input error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (nullable SSDOcrOutput *)predictionFromFeatures:(SSDOcrInput *)input options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (void)predictionFromFeatures:(SSDOcrInput *)input completionHandler:(void (^)(SSDOcrOutput * _Nullable output, NSError * _Nullable error))completionHandler API_AVAILABLE(macos(14.0), ios(17.0), watchos(10.0), tvos(17.0)) __attribute__((visibility("hidden")));
- (void)predictionFromFeatures:(SSDOcrInput *)input options:(MLPredictionOptions *)options completionHandler:(void (^)(SSDOcrOutput * _Nullable output, NSError * _Nullable error))completionHandler API_AVAILABLE(macos(14.0), ios(17.0), watchos(10.0), tvos(17.0)) __attribute__((visibility("hidden")));
- (nullable SSDOcrOutput *)predictionFrom_0:(CVPixelBufferRef)_0 error:(NSError * _Nullable __autoreleasing * _Nullable)error;
- (nullable NSArray<SSDOcrOutput *> *)predictionsFromInputs:(NSArray<SSDOcrInput*> *)inputArray options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error API_AVAILABLE(macos(10.14), ios(12.0), watchos(5.0), tvos(12.0)) __attribute__((visibility("hidden")));
@end

NS_ASSUME_NONNULL_END
