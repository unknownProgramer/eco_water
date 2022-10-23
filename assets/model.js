import * as THREE from '/build/three.module.js';
import { OrbitControls } from  '../node_modules/three/examples/jsm/controls/OrbitControls';
import { Water } from '../node_modules/three/examples/jsm/objects/Water2';

let scene, camera, clock, renderer, water;
let params = {
    '담수 색상': '#ffffff',
    '담수 높이' : 45
};
init();
animate();
function init() {
    ///////////////////
    //     SCENE     //
    ///////////////////
    scene = new THREE.Scene();

    /////////////////////
    //      CAMERA     //
    /////////////////////
    camera = new THREE.PerspectiveCamera( 75, window.innerWidth / window.innerHeight, 0.1, 1000 );
    camera.position.set( 60, 100, 0 );
    camera.lookAt( scene.position );

    ///////////////////
    //     CLOCK     //
    ///////////////////
    clock = new THREE.Clock();

    //////////////////////
    //     GEOMETRY     //
    //////////////////////
    // texture load
    const loader = new THREE.TextureLoader();
    const height = loader.load('/assets/depth_img/pd_depth.jpg');
    const texture = loader.load('/assets/depth_img/pd_depth_color.jpg');
    height.warpS = height.wrapT = THREE.RepeatWrapping;

    // 지면 init
    const geometry = new THREE.PlaneGeometry(256, 256, 64, 64) // segments 가 높을수록 더 세밀한 오브젝트 생성이 가능

    // 저수지 수심 init ( wireframe : 격자표현 )
    const material = new THREE.MeshStandardMaterial({
        color          : '#ffffff',
        map            : texture,
        displacementMap: height,
        // wireframe: true,
        displacementScale: 64
    });
    material.side = THREE.DoubleSide;

    // 지면 객체 init
    const plane = new THREE.Mesh(geometry, material);

    // 지면 객체 위치조정
    plane.rotation.x = -Math.PI / 2;

    // 지면 객체 추가
    scene.add(plane);

    ///////////////////
    //     WATER     //
    ///////////////////
    const waterGeometry = new THREE.PlaneGeometry( 256, 256 );

    water = new Water( waterGeometry, {
        color : params["담수 색상"],
        scale : 1,
        flowDirection : new THREE.Vector2( 1, 1 ),
        textureWidth : 128,
        textureHeight : 128,
    } );
    water.position.y = params["담수 높이"];
    water.rotation.x = Math.PI * - 0.5;
    scene.add( water );

    ///////////////////
    //      CUBE     //
    ///////////////////
    const cubeTextureLoader = new THREE.CubeTextureLoader();
    cubeTextureLoader.setPath( 'textures/cube/skyboxsun25deg/' );
    const cubeTexture = cubeTextureLoader.load( [
        'px.jpg', 'nx.jpg',
        'py.jpg', 'ny.jpg',
        'pz.jpg', 'nz.jpg'
    ] );
    scene.background = cubeTexture;

    ///////////////////
    //     LIGHT     //
    ///////////////////
    const ambientLight = new THREE.AmbientLight(0xf0f0f0);
    scene.add( ambientLight );

    const directionalLight = new THREE.DirectionalLight(0x808080, 1.0);
    directionalLight.position.set( 2, 2, 3 );
    scene.add( directionalLight );

    //////////////////////
    //     RENDERER     //
    //////////////////////
    // const renderer = new THREE.WebGLRenderer({canvas});
    const canvas = document.querySelector('#canvas');

    renderer = new THREE.WebGLRenderer( { canvas } );
    renderer.setSize( window.innerWidth, window.innerHeight );
    renderer.setPixelRatio( window.devicePixelRatio );
    // document.body.appendChild( renderer.domElement );
    // const renderer = new THREE.WebGLRenderer({antialias: true, preserveDrawingBuffer: true});

    // renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setSize(700,500);
    // document.body.appendChild(renderer.domElement);

    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFShadowMap;

    /////////////////
    //     GUI     //
    /////////////////
    // const gui = new GUI();
    // gui.addColor( params, '담수 색상' ).onChange( function ( value ) {
    //   water.material.uniforms[ 'color' ].value.set( value );
    // } );
    // gui.add( params, '담수 높이', 25, 50, 0.5 ).onChange( function ( value ) {
    //   water.position.y = value;
    // });
    // gui.open();

    //////////////////////
    //     CONTROLS     //
    //////////////////////
    const controls = new OrbitControls( camera, renderer.domElement );
    controls.minDistance = 50;
    controls.maxDistance = 500;
    window.addEventListener( 'resize', onWindowResize );
}
function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize( window.innerWidth, window.innerHeight );
}
function animate() {
    requestAnimationFrame( animate );
    // scene.rotation.y += 0.02;
    render();
}
function render() {
    renderer.render( scene, camera );
}