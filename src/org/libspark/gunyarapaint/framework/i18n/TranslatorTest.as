package org.libspark.gunyarapaint.framework.i18n
{
    import org.flexunit.Assert;

    public class TranslatorTest
    {
        [Test]
        public function test1():void
        //public function TranslatorRegistryはNullTranslatorが入っていること():void
        {
            Assert.assertTrue(TranslatorRegistry.translator is NullTranslator);
        }
        
        [Test]
        public function test2():void
        //public function TranslatorRegistry#installで上書きするとtranslatorはそのクラスを返す():void
        {
            var translator:FakeTranslator = new FakeTranslator();
            TranslatorRegistry.install(translator);
            Assert.assertTrue(TranslatorRegistry.translator is FakeTranslator);
        }
        
        [Test]
        public function test3():void
        //public function NullTranslatorは少なくともgettext形式の引数を置換する能力を持つ
        {
            Assert.assertEquals(
                "This is a test, test2 and test3",
                TranslatorRegistry.tr("This is a %s, %s and %s", "test", "test2", "test3")
            );
        }
    }
}
