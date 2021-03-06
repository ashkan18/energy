#import "ARBackgroundSettingsViewController.h"
#import "AROptions.h"
#import "ARToggleSwitch.h"
#import "ARTableViewCell.h"
#import "ARTheme.h"

#import "UIViewController+SettingsNavigationItemHelpers.h"


@implementation ARBackgroundSettingsViewController

@synthesize section;

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (!self) return nil;

    self.section = ARSettingsSectionBackground;

    self.title = @"Background".uppercaseString;

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupNavigationBar];

    /// extends the height of the tableview header; unfortunately, you can't do this with autolayout size classes yet
    if ([UIDevice isPhone]) {
        UIView *header = self.tableView.tableHeaderView;
        CGRect frame = header.frame;
        frame.size.height = frame.size.height + 20;
        header.frame = frame;
        [self.tableView updateConstraintsIfNeeded];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[ARTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"backgroundCell"];
    cell.textLabel.text = NSLocalizedString(@"White Background", @"Title for white Folio setting toggle");
    cell.textLabel.font = [UIFont serifFontWithSize:17];

    ARToggleSwitch *toggle = [ARToggleSwitch buttonWithFrame:CGRectMake(0, 0, 76, 28)];
    toggle.on = self.usingWhiteFolio;
    toggle.userInteractionEnabled = NO;

    cell.accessoryView = toggle;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BOOL on = !self.usingWhiteFolio;
    [self setWhiteFolio:on];

    ARToggleSwitch *toggle = (id)[tableView cellForRowAtIndexPath:indexPath].accessoryView;
    toggle.on = on;

    [ARTheme setupWithWhiteFolio:on];

    [[NSNotificationCenter defaultCenter] postNotificationName:ARUserDidChangeGridFilteringSettingsNotification object:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (BOOL)usingWhiteFolio
{
    return [self.defaults boolForKey:AROptionsUseWhiteFolio];
}

- (void)setWhiteFolio:(BOOL)on
{
    [self.defaults setBool:on forKey:AROptionsUseWhiteFolio];
    [self.defaults synchronize];
}

- (NSUserDefaults *)defaults
{
    return _defaults ?: [NSUserDefaults standardUserDefaults];
}

- (void)setupNavigationBar
{
    if ([UIDevice isPhone]) [self addSettingsBackButtonWithTarget:@selector(returnToMasterViewController) animated:YES];
}


- (void)returnToMasterViewController
{
    [self.navigationController.navigationController popToRootViewControllerAnimated:YES];
}

@end
