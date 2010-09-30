package com.github.niji.gunyarapaint.ui.v1.i18n
{
    import com.github.niji.framework.i18n.ITranslator;
    import com.github.niji.framework.i18n.TranslatorRegistry;
    import com.github.niji.gunyarapaint.ui.i18n.GetTextTranslator;
    
    import org.flexunit.Assert;

    public final class GetTextTranslatorTest
    {
        [Test(description="引数が展開されて文字列を返すこと")]
        public function shouldExpandArguments():void
        {
            TranslatorRegistry.install(new GetTextTranslator());
            Assert.assertEquals("test", TranslatorRegistry.tr("test"));
            Assert.assertEquals("test 1 2 3", TranslatorRegistry.tr("test %s %s %s", 1, 2, 3));
        }
    }
}
