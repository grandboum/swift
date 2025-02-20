#ifndef _USING_BASE_MEMBERS_H
#define _USING_BASE_MEMBERS_H

struct PublicBase {
private:
  int value = 123;

public:
  int publicGetter() const { return value; }
  void publicSetter(int v) { value = v; }
  void notExposed() const {}
};

struct PublicBasePrivateInheritance : private PublicBase {
  using PublicBase::publicGetter;
  using PublicBase::publicSetter;
};

struct PublicBaseProtectedInheritance : protected PublicBase {
  using PublicBase::publicGetter;
  using PublicBase::publicSetter;
};

struct IntBox {
  int value;
  IntBox(int value) : value(value) {}
  IntBox(unsigned value) : value(value) {}
};

struct UsingBaseConstructorWithParam : IntBox {
  using IntBox::IntBox;
};

struct Empty {};

struct UsingBaseConstructorEmpty : private Empty {
  using Empty::Empty;

  int value = 456;
};

struct ProtectedBase {
protected:
  int protectedGetter() const { return 456; }
};

struct ProtectedMemberPrivateInheritance : private ProtectedBase {
  using ProtectedBase::protectedGetter;
};

#endif // !_USING_BASE_MEMBERS_H
