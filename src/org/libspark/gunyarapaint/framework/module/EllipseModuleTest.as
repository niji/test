package org.libspark.gunyarapaint.framework.module
{
    import flash.utils.ByteArray;
    
    import org.flexunit.Assert;
    import org.libspark.gunyarapaint.framework.Recorder;
    import org.libspark.gunyarapaint.framework.modules.DrawModuleFactory;
    import org.libspark.gunyarapaint.framework.modules.IDrawable;

    public final class EllipseModuleTest
    {
        [Test]
        public function createInstance():void
        {
            var recorder:Recorder = new Recorder(new ByteArray());
            var module:IDrawable = DrawModuleFactory.create(DrawModuleFactory.ELLIPSE, recorder);
            Assert.assertEquals(module.name, DrawModuleFactory.ELLIPSE);
        }
    }
}
