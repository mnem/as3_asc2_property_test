package
{
  import flash.display.Sprite;
  import flash.text.TextField;

  public class Main
    extends Sprite
  {
    private var _output:TextField;

    public function Main()
    {
      _output = new TextField();
      _output.width = stage.stageWidth;
      _output.height = stage.stageHeight;
      addChild(_output);

      puts("Using private setter with 'bish'");
      privateProperty = 'bish';
      puts("Using private getter: " + privateProperty);
      puts('')
      puts("Using protected setter with 'bash'");
      protectedProperty = 'bash';
      puts("Using protected getter: " + protectedProperty);
      puts('')
      puts("Using internal setter with 'bosh'");
      internalProperty = 'bosh';
      puts("Using internal getter: " + internalProperty);
      puts('')
      puts("Using public setter with 'ehrmbingle'");
      publicProperty = 'ehrmbingle';
      puts("Using public getter: " + publicProperty);
    }

    private function puts(string:String):void
    {
      _output.appendText(string + '\n');
    }

    private var _privatePropertyStore:String = '';
    private function get privateProperty():String
    {
      return _privatePropertyStore;
    }
    private function set privateProperty(value:String):void
    {
      _privatePropertyStore = value;
    }

    private var _protectedPropertyStore:String = '';
    protected function get protectedProperty():String
    {
      return _protectedPropertyStore;
    }
    protected function set protectedProperty(value:String):void
    {
      _protectedPropertyStore = value;
    }

    private var _internalPropertyStore:String = '';
    internal function get internalProperty():String
    {
      return _internalPropertyStore;
    }
    internal function set internalProperty(value:String):void
    {
      _internalPropertyStore = value;
    }

    private var _publicPropertyStore:String = '';
    public function get publicProperty():String
    {
      return _publicPropertyStore;
    }
    public function set publicProperty(value:String):void
    {
      _publicPropertyStore = value;
    }
  }
}
