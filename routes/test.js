
for ( let i = 0 ; i < 7 ; i++) {
    let star = 1;
    if ( star < 7 ) {
        console.log('*' * star)
        star += 2;
    } else {
        console.log('*' * star);
        star -= 2;
    }
}