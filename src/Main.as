package
{
  public class Main
    extends SneakyLittleBase
  {
    public function Main()
    {
      super();
      puts('')
      puts("FROM SUBCLASS: Using protected setter with 'mylittlebash'");
      protectedProperty = 'mylittlebash';
      puts("FROM SUBCLASS: Using protected getter: " + protectedProperty);
    }
  }
}
