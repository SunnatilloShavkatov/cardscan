//
// SSDOcr.m
//
// This file was automatically generated and should not be edited.
//

#if !__has_feature(objc_arc)
#error This file must be compiled with automatic reference counting enabled (-fobjc-arc)
#endif

#import "SSDOcr.h"

@implementation SSDOcrInput

- (instancetype)initWith_0:(CVPixelBufferRef)_0 {
    self = [super init];
    if (self) {
        __0 = _0;
        CVPixelBufferRetain(__0);
    }
    return self;
}

- (void)dealloc {
    CVPixelBufferRelease(__0);
}

- (nullable instancetype)initWith_0FromCGImage:(CGImageRef)_0 error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    if (self) {
        NSError *localError;
        BOOL result = YES;
        id retVal = nil;
        @autoreleasepool {
            do {
                MLFeatureValue * ___0 = [MLFeatureValue featureValueWithCGImage:_0 pixelsWide:600 pixelsHigh:375 pixelFormatType:kCVPixelFormatType_32ARGB options:nil error:&localError];
                if (___0 == nil) {
                    result = NO;
                    break;
                }
                retVal = [self initWith_0:(CVPixelBufferRef)___0.imageBufferValue];
            }
            while(0);
        }
        if (error != NULL) {
            *error = localError;
        }
        return result ? retVal : nil;
    }
    return self;
}

- (nullable instancetype)initWith_0AtURL:(NSURL *)_0URL error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    if (self) {
        NSError *localError;
        BOOL result = YES;
        id retVal = nil;
        @autoreleasepool {
            do {
                MLFeatureValue * ___0 = [MLFeatureValue featureValueWithImageAtURL:_0URL pixelsWide:600 pixelsHigh:375 pixelFormatType:kCVPixelFormatType_32ARGB options:nil error:&localError];
                if (___0 == nil) {
                    result = NO;
                    break;
                }
                retVal = [self initWith_0:(CVPixelBufferRef)___0.imageBufferValue];
            }
            while(0);
        }
        if (error != NULL) {
            *error = localError;
        }
        return result ? retVal : nil;
    }
    return self;
}

-(BOOL)set_0WithCGImage:(CGImageRef)_0 error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    NSError *localError;
    BOOL result = NO;
    @autoreleasepool {
        MLFeatureValue * ___0 = [MLFeatureValue featureValueWithCGImage:_0 pixelsWide:600 pixelsHigh:375 pixelFormatType:kCVPixelFormatType_32ARGB options:nil error:&localError];
        if (___0 != nil) {
            CVPixelBufferRelease(self._0);
            self._0 =  (CVPixelBufferRef)___0.imageBufferValue;
            CVPixelBufferRetain(self._0);
            result = YES;
        }
    }
    if (error != NULL) {
        *error = localError;
    }
    return result;
}

-(BOOL)set_0WithURL:(NSURL *)_0URL error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    NSError *localError;
    BOOL result = NO;
    @autoreleasepool {
        MLFeatureValue * ___0 = [MLFeatureValue featureValueWithImageAtURL:_0URL pixelsWide:600 pixelsHigh:375 pixelFormatType:kCVPixelFormatType_32ARGB options:nil error:&localError];
        if (___0 != nil) {
            CVPixelBufferRelease(self._0);
            self._0 =  (CVPixelBufferRef)___0.imageBufferValue;
            CVPixelBufferRetain(self._0);
            result = YES;
        }
    }
    if (error != NULL) {
        *error = localError;
    }
    return result;
}

- (NSSet<NSString *> *)featureNames {
    return [NSSet setWithArray:@[@"0"]];
}

- (nullable MLFeatureValue *)featureValueForName:(NSString *)featureName {
    if ([featureName isEqualToString:@"0"]) {
        return [MLFeatureValue featureValueWithPixelBuffer:self._0];
    }
    return nil;
}

@end

@implementation SSDOcrOutput

- (instancetype)initWithScores:(MLMultiArray *)scores boxes:(MLMultiArray *)boxes filter:(MLMultiArray *)filter {
    self = [super init];
    if (self) {
        _scores = scores;
        _boxes = boxes;
        _filter = filter;
    }
    return self;
}

- (NSSet<NSString *> *)featureNames {
    return [NSSet setWithArray:@[@"scores", @"boxes", @"filter"]];
}

- (nullable MLFeatureValue *)featureValueForName:(NSString *)featureName {
    if ([featureName isEqualToString:@"scores"]) {
        return [MLFeatureValue featureValueWithMultiArray:self.scores];
    }
    if ([featureName isEqualToString:@"boxes"]) {
        return [MLFeatureValue featureValueWithMultiArray:self.boxes];
    }
    if ([featureName isEqualToString:@"filter"]) {
        return [MLFeatureValue featureValueWithMultiArray:self.filter];
    }
    return nil;
}

@end

@implementation SSDOcr

+ (nullable NSURL *)URLOfModelInThisBundle {
    NSString *assetPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"SSDOcr" ofType:@"mlmodelc"];
    if (nil == assetPath) { os_log_error(OS_LOG_DEFAULT, "Could not load SSDOcr.mlmodelc in the bundle resource"); return nil; }
    return [NSURL fileURLWithPath:assetPath];
}

- (instancetype)initWithMLModel:(MLModel *)model {
    if (model == nil) {
        return nil;
    }
    self = [super init];
    if (self != nil) {
        _model = model;
    }
    return self;
}

- (nullable instancetype)init {
    return [self initWithContentsOfURL:(NSURL * _Nonnull)self.class.URLOfModelInThisBundle error:nil];
}

- (nullable instancetype)initWithConfiguration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    return [self initWithContentsOfURL:(NSURL * _Nonnull)self.class.URLOfModelInThisBundle configuration:configuration error:error];
}

- (nullable instancetype)initWithContentsOfURL:(NSURL *)modelURL error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    MLModel *model = [MLModel modelWithContentsOfURL:modelURL error:error];
    if (model == nil) { return nil; }
    return [self initWithMLModel:model];
}

- (nullable instancetype)initWithContentsOfURL:(NSURL *)modelURL configuration:(MLModelConfiguration *)configuration error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    MLModel *model = [MLModel modelWithContentsOfURL:modelURL configuration:configuration error:error];
    if (model == nil) { return nil; }
    return [self initWithMLModel:model];
}

+ (void)loadWithConfiguration:(MLModelConfiguration *)configuration completionHandler:(void (^)(SSDOcr * _Nullable model, NSError * _Nullable error))handler {
    [self loadContentsOfURL:(NSURL * _Nonnull)[self URLOfModelInThisBundle]
              configuration:configuration
          completionHandler:handler];
}

+ (void)loadContentsOfURL:(NSURL *)modelURL configuration:(MLModelConfiguration *)configuration completionHandler:(void (^)(SSDOcr * _Nullable model, NSError * _Nullable error))handler {
    [MLModel loadContentsOfURL:modelURL
                 configuration:configuration
             completionHandler:^(MLModel *model, NSError *error) {
        if (model != nil) {
            SSDOcr *typedModel = [[SSDOcr alloc] initWithMLModel:model];
            handler(typedModel, nil);
        } else {
            handler(nil, error);
        }
    }];
}

- (nullable SSDOcrOutput *)predictionFromFeatures:(SSDOcrInput *)input error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    return [self predictionFromFeatures:input options:[[MLPredictionOptions alloc] init] error:error];
}

- (nullable SSDOcrOutput *)predictionFromFeatures:(SSDOcrInput *)input options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    id<MLFeatureProvider> outFeatures = [self.model predictionFromFeatures:input options:options error:error];
    if (!outFeatures) { return nil; }
    return [[SSDOcrOutput alloc] initWithScores:(MLMultiArray *)[outFeatures featureValueForName:@"scores"].multiArrayValue boxes:(MLMultiArray *)[outFeatures featureValueForName:@"boxes"].multiArrayValue filter:(MLMultiArray *)[outFeatures featureValueForName:@"filter"].multiArrayValue];
}

- (void)predictionFromFeatures:(SSDOcrInput *)input completionHandler:(void (^)(SSDOcrOutput * _Nullable output, NSError * _Nullable error))completionHandler {
    [self.model predictionFromFeatures:input completionHandler:^(id<MLFeatureProvider> prediction, NSError *predictionError) {
        if (prediction != nil) {
            SSDOcrOutput *output = [[SSDOcrOutput alloc] initWithScores:(MLMultiArray *)[prediction featureValueForName:@"scores"].multiArrayValue boxes:(MLMultiArray *)[prediction featureValueForName:@"boxes"].multiArrayValue filter:(MLMultiArray *)[prediction featureValueForName:@"filter"].multiArrayValue];
            completionHandler(output, predictionError);
        } else {
            completionHandler(nil, predictionError);
        }
    }];
}

- (void)predictionFromFeatures:(SSDOcrInput *)input options:(MLPredictionOptions *)options completionHandler:(void (^)(SSDOcrOutput * _Nullable output, NSError * _Nullable error))completionHandler {
    [self.model predictionFromFeatures:input options:options completionHandler:^(id<MLFeatureProvider> prediction, NSError *predictionError) {
        if (prediction != nil) {
            SSDOcrOutput *output = [[SSDOcrOutput alloc] initWithScores:(MLMultiArray *)[prediction featureValueForName:@"scores"].multiArrayValue boxes:(MLMultiArray *)[prediction featureValueForName:@"boxes"].multiArrayValue filter:(MLMultiArray *)[prediction featureValueForName:@"filter"].multiArrayValue];
            completionHandler(output, predictionError);
        } else {
            completionHandler(nil, predictionError);
        }
    }];
}

- (nullable SSDOcrOutput *)predictionFrom_0:(CVPixelBufferRef)_0 error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    SSDOcrInput *input_ = [[SSDOcrInput alloc] initWith_0:_0];
    return [self predictionFromFeatures:input_ error:error];
}

- (nullable NSArray<SSDOcrOutput *> *)predictionsFromInputs:(NSArray<SSDOcrInput*> *)inputArray options:(MLPredictionOptions *)options error:(NSError * _Nullable __autoreleasing * _Nullable)error {
    id<MLBatchProvider> inBatch = [[MLArrayBatchProvider alloc] initWithFeatureProviderArray:inputArray];
    id<MLBatchProvider> outBatch = [self.model predictionsFromBatch:inBatch options:options error:error];
    if (!outBatch) { return nil; }
    NSMutableArray<SSDOcrOutput*> *results = [NSMutableArray arrayWithCapacity:(NSUInteger)outBatch.count];
    for (NSInteger i = 0; i < outBatch.count; i++) {
        id<MLFeatureProvider> resultProvider = [outBatch featuresAtIndex:i];
        SSDOcrOutput * result = [[SSDOcrOutput alloc] initWithScores:(MLMultiArray *)[resultProvider featureValueForName:@"scores"].multiArrayValue boxes:(MLMultiArray *)[resultProvider featureValueForName:@"boxes"].multiArrayValue filter:(MLMultiArray *)[resultProvider featureValueForName:@"filter"].multiArrayValue];
        [results addObject:result];
    }
    return results;
}

@end
