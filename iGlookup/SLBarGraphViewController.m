//
//  SLBarGraphViewController.m
//  iGlookup
//
//  Created by Donny Reynolds on 5/9/14.
//  Copyright (c) 2014 Scouting Legion. All rights reserved.
//

#import "SLBarGraphViewController.h"
#import "SLDistribution.h"

@interface SLBarGraphViewController () {
    NSInteger bins;
    CGFloat maxValue;
    CGFloat barWidth;
}

@property (nonatomic, strong) SLDistribution *distribution;
@property (nonatomic, strong) IBOutlet CPTGraphHostingView *hostView;
@property (nonatomic, strong) CPTBarPlot *distPlot;
@property (nonatomic, strong) CPTPlotSpaceAnnotation *annotation;

-(void)initPlot;
-(void)configureGraph;
-(void)configurePlots;
-(void)configureAxes;
-(void)hideAnnotation:(CPTGraph *)graph;

@end

@implementation SLBarGraphViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

#pragma mark - UIViewController lifecycle methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPlot];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Chart behavior
-(void)initPlot {
    bins = [_distribution.numInBin count];
    maxValue = [[_distribution.numInBin valueForKeyPath:@"@max.intValue"] floatValue];
    barWidth = 1.0f;
    self.hostView.allowPinchScaling = NO;
    [self configureGraph];
    [self configurePlots];
    [self configureAxes];
}

-(void)configureGraph {
	// 1 - Create the graph
	CPTGraph *graph = [[CPTXYGraph alloc] initWithFrame:self.hostView.bounds];

	graph.plotAreaFrame.masksToBorder = NO;
	self.hostView.hostedGraph = graph;
    
	// 2 - Configure the graph
	[graph applyTheme:[CPTTheme themeNamed:kCPTPlainWhiteTheme]];
    graph.plotAreaFrame.borderLineStyle = nil; //no graph border
	graph.paddingBottom = 20.0f;
	graph.paddingLeft  = 40.0f;
	graph.paddingTop    = 20.0f;
	graph.paddingRight  = 40.0f;
    
	// 3 - Set up styles
    /*
	CPTMutableTextStyle *titleStyle = [CPTMutableTextStyle textStyle];
	titleStyle.color = [CPTColor blackColor];
	titleStyle.fontName = @"Helvetica-Bold";
	titleStyle.fontSize = 16.0f;
    */
    
	// 4 - Set up title
	/*
    NSString *title = @"Grade Distribution";
	graph.title = title;
	graph.titleTextStyle = titleStyle;
	graph.titlePlotAreaFrameAnchor = CPTRectAnchorTop;
	graph.titleDisplacement = CGPointMake(0.0f, -16.0f);
    */
    
	// 5 - Set up plot space
	CGFloat xMin = 0.0f;
	CGFloat xMax = maxValue;
	CGFloat yMin = 0.0f;
	CGFloat yMax = bins;  // should determine dynamically based on max price
	CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
	plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(xMin) length:CPTDecimalFromFloat(xMax)];
	plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(yMin) length:CPTDecimalFromFloat(yMax)];
}

-(void)configurePlots {
	// 1 - Set up plot
	self.distPlot = [CPTBarPlot tubularBarPlotWithColor:[CPTColor darkGrayColor] horizontalBars:YES]; //gives horizontal graph
    [self.distPlot setBarCornerRadius:0]; //no rounded bars
    self.distPlot.fill = [CPTFill fillWithColor:[CPTColor darkGrayColor]]; //no gradient
	self.distPlot.identifier = @"Distribution";

	// 2 - Set up line style
	CPTMutableLineStyle *barLineStyle = [[CPTMutableLineStyle alloc] init];
	barLineStyle.lineColor = [CPTColor whiteColor]; //separation between bars
	barLineStyle.lineWidth = 1.0;
    
	// 3 - Add plots to graph
	CPTGraph *graph = self.hostView.hostedGraph;

    _distPlot.dataSource = self;
    _distPlot.delegate = self;
    _distPlot.barWidth = CPTDecimalFromDouble(barWidth);

    _distPlot.lineStyle = barLineStyle;
    [graph addPlot:_distPlot toPlotSpace:graph.defaultPlotSpace];

}

-(void)configureAxes {
	// 1 - Configure styles
	CPTMutableTextStyle *axisTitleStyle = [CPTMutableTextStyle textStyle];
	axisTitleStyle.color = [CPTColor blackColor];
	axisTitleStyle.fontName = @"Helvetica Nueue";
	axisTitleStyle.fontSize = 12.0f;
    
	CPTMutableLineStyle *axisLineStyle = [CPTMutableLineStyle lineStyle];
	axisLineStyle.lineWidth = 0.0f;
	axisLineStyle.lineColor = [[CPTColor darkGrayColor] colorWithAlphaComponent:1];
    
	// 2 - Get the graph's axis set
	CPTXYAxisSet *axisSet = (CPTXYAxisSet *) self.hostView.hostedGraph.axisSet;
	
    // 3 - Configure the x-axis
	axisSet.xAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
//	axisSet.xAxis.title = @"Students";
//	axisSet.xAxis.titleTextStyle = axisTitleStyle;
//	axisSet.xAxis.titleOffset = 10.0f;
	axisSet.xAxis.axisLineStyle = axisLineStyle;
    axisSet.xAxis.majorTickLineStyle = axisLineStyle;
    axisSet.xAxis.majorTickLength = 1.0;
    axisSet.xAxis.tickDirection = CPTSignPositive;


    
	// 4 - Configure the y-axis
	axisSet.yAxis.labelingPolicy = CPTAxisLabelingPolicyNone;
//	axisSet.yAxis.title = @"Scores";
//	axisSet.yAxis.titleTextStyle = axisTitleStyle;
//	axisSet.yAxis.titleOffset = 5.0f;
	axisSet.yAxis.axisLineStyle = axisLineStyle;
    
    NSArray *numInBin = _distribution.numInBin;
    NSArray *upperBounds = _distribution.upperBounds;
    NSMutableSet *yLabels = [NSMutableSet setWithCapacity:bins];
    NSMutableSet *yLocations = [NSMutableSet setWithCapacity:bins];
    NSInteger i = 0;
    while (i<[numInBin count]) {
        
		CPTAxisLabel *label = [[CPTAxisLabel alloc] initWithText:[NSString stringWithFormat:@"%@",upperBounds[i]]  textStyle:axisSet.yAxis.labelTextStyle];
		CGFloat location = i++;
		label.tickLocation = CPTDecimalFromCGFloat(location);
		label.offset = axisSet.yAxis.majorTickLength;
        if (label) {
            [yLabels addObject:label];
            [yLocations addObject:[NSNumber numberWithFloat:location]];
        }
    }
    axisSet.yAxis.axisLabels = yLabels;
    axisSet.yAxis.majorTickLocations = yLocations;
}

#pragma mark - CPTPlotDataSource methods
-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot {
	return bins;
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index {
	if ((fieldEnum == CPTBarPlotFieldBarTip) && (index < bins)) {
		if ([plot.identifier isEqual:@"Distribution"]) {
            srand(time(NULL));
//			return [NSNumber numberWithInteger:(_distribution.numInBin)[index]];
            return [_distribution.numInBin objectAtIndex:index];
		}
	}
	return [NSDecimalNumber numberWithUnsignedInteger:index];
}

#pragma mark - CPTBarPlotDelegate methods
-(void)barPlot:(CPTBarPlot *)plot barWasSelectedAtRecordIndex:(NSUInteger)index {
	// 1 - Is the plot hidden?
	if (plot.isHidden == YES) {
		return;
	}
	
    // 2 - Create style, if necessary
	static CPTMutableTextStyle *style = nil;
	if (!style) {
		style = [CPTMutableTextStyle textStyle];
		style.color= [CPTColor brownColor];
		style.fontSize = 16.0f;
		style.fontName = @"Helvetica-Bold";
	}
	
    // 3 - Create annotation, if necessary
	NSNumber *numStudents = [self numberForPlot:plot field:CPTBarPlotFieldBarTip recordIndex:index];
	if (!self.annotation) {
		NSNumber *x = [NSNumber numberWithInt:0];
		NSNumber *y = [NSNumber numberWithInt:0];
		NSArray *anchorPoint = [NSArray arrayWithObjects:x, y, nil];
		self.annotation = [[CPTPlotSpaceAnnotation alloc] initWithPlotSpace:plot.plotSpace anchorPlotPoint:anchorPoint];
	}
	
    // 4 - Create number formatter, if needed
	static NSNumberFormatter *formatter = nil;
	if (!formatter) {
		formatter = [[NSNumberFormatter alloc] init];
		[formatter setMaximumFractionDigits:2];
	}
	
    // 5 - Create text layer for annotation
	NSString *priceValue = [formatter stringFromNumber:numStudents];
	CPTTextLayer *textLayer = [[CPTTextLayer alloc] initWithText:priceValue style:style];
	self.annotation.contentLayer = textLayer;
	
    // 6 - Get plot index based on identifier
	NSInteger plotIndex = 0;
	if ([plot.identifier isEqual:@"Distribution"] == YES) {
		plotIndex = 0;
	} //more cases
    
	// 7 - Get the anchor point for annotation
	CGFloat x = index  + (plotIndex * barWidth);
	NSNumber *anchorX = [NSNumber numberWithFloat:x];
	CGFloat y = [numStudents floatValue] + 40.0f;
	NSNumber *anchorY = [NSNumber numberWithFloat:y];
	self.annotation.anchorPlotPoint = [NSArray arrayWithObjects:anchorX, anchorY, nil];
    
	// 8 - Add the annotation
	[plot.graph.plotAreaFrame.plotArea addAnnotation:self.annotation];
}

- (void)setDistribution:(SLDistribution *)distribution
{
    if (_distribution != distribution) {
        _distribution = distribution;
        //temporary fix
        NSMutableArray *newUpperBounds = [NSMutableArray arrayWithArray:_distribution.upperBounds];
        [newUpperBounds insertObject:[NSNumber numberWithInt:0] atIndex:0];
        _distribution.upperBounds = newUpperBounds;
        // Update the view.
        [self initPlot];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
