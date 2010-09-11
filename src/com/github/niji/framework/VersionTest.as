package com.github.niji.framework
{
    import org.flexunit.Assert;
    import com.github.niji.framework.Version;
    
    public final class VersionTest
    {
        [Datapoints]
        public static var dates:Array = [
            [ -1, 0 ],
            [ -1, Version.DATE - 1 ],
            [ 0, Version.DATE ],
            [ 1, Version.DATE + 1 ],
            [ 1, uint.MAX_VALUE ]
        ];
        
        [Datapoints]
        public static var logVersions:Array = [
            [ -1, 0 ],
            [ -1, Version.LOG_VERSION - 1 ],
            [ 0, Version.LOG_VERSION ],
            [ 1, Version.LOG_VERSION + 1 ],
            [ 1, uint.MAX_VALUE ]
        ];
        
        [Test]
        public function shouldCompareDateCorrectly():void
        {
            for (var i:String in dates) {
                var date:Array = dates[i];
                Assert.assertEquals(date[0], Version.compareDate(date[1]));
            }
        }
        
        [Test]
        public function shouldCompareLogVersionCorrectly():void
        {
            for (var i:String in logVersions) {
                var version:Array = logVersions[i];
                Assert.assertEquals(version[0], Version.compareLogVersion(version[1]));
            }
        }
    }
}
