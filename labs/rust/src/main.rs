fn main() {
    let test = 10;
    let mut test2 = 20;

    println!("Hello, {}! -> {}", test, test2);
    test2 = 30;
    println!("Hello, {}! -> {}", test, test2);

    todo!("Display the message by using the {} macro", test2);
}
