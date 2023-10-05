import * as THREE from 'three';
import { OrbitControls } from '/jsm/controls/OrbitControls.js';
import { Water } from '/jsm/objects/Water2.js';

let scene, camera, clock, renderer, water;
let params = {
    '담수 색상': '#FFFFFF',
    '담수 높이': 45
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
    camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
    camera.position.set(150, 100, 25);
    camera.lookAt(scene.position);

    ///////////////////
    //     CLOCK     //
    ///////////////////
    clock = new THREE.Clock();

    //////////////////////
    //     GEOMETRY     //
    //////////////////////
    // texture load
    const loader = new THREE.TextureLoader();
    const height = loader.load('/depth_img/pd_depth.jpg');
    const texture = loader.load('/depth_img/pd_depth_color.jpg');
    height.warpS = height.wrapT = THREE.RepeatWrapping;

    // 지면 init
    const geometry = new THREE.PlaneGeometry(256, 256, 64, 64)

    // 저수지 수심 init
    const material = new THREE.MeshStandardMaterial({
        color: '#ffffff',
        map: texture,
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
    const waterGeometry = new THREE.PlaneGeometry(256, 256);

    water = new Water(waterGeometry, {
        color: params["담수 색상"],
        scale: 1,
        flowDirection: new THREE.Vector2(1, 1),
        textureWidth: 128,
        textureHeight: 128
    });
    water.position.y = params["담수 높이"];
    water.rotation.x = Math.PI * -0.5;
    scene.add(water);

    ///////////////////
    //      CUBE     //
    ///////////////////
    const cubeTextureLoader = new THREE.CubeTextureLoader();
    // cubeTextureLoader.setPath( '/skyboxsun25deg/' );
    const cubeTexture = cubeTextureLoader.load([
        'skyboxsun25deg/px.jpg', 'skyboxsun25deg/nx.jpg',
        'skyboxsun25deg/py.jpg', 'skyboxsun25deg/ny.jpg',
        'skyboxsun25deg/pz.jpg', 'skyboxsun25deg/nz.jpg'
    ]);
    scene.background = cubeTexture;

    ///////////////////
    //     LIGHT     //
    ///////////////////
    const ambientLight = new THREE.AmbientLight(0xf0f0f0);
    scene.add(ambientLight);

    const directionalLight = new THREE.DirectionalLight(0x808080, 1.0);
    directionalLight.position.set(2, 2, 3);
    scene.add(directionalLight);

    //////////////////////
    //     RENDERER     //
    //////////////////////
    const canvas = document.querySelector('#lender_canvas');
    renderer = new THREE.WebGLRenderer({ canvas });
    renderer.setSize(window.innerWidth, window.innerHeight);
    renderer.setPixelRatio(window.devicePixelRatio);
    renderer.setSize(840, 480);

    renderer.shadowMap.enabled = true;
    renderer.shadowMap.type = THREE.PCFShadowMap;

    //////////////////////
    //     CONTROLS     //
    //////////////////////
    const controls = new OrbitControls(camera, renderer.domElement);
    controls.minDistance = 125;
    controls.maxDistance = 350;
    controls.maxPolarAngle = 1;
    window.addEventListener('resize', onWindowResize);
}

function onWindowResize() {
    camera.aspect = window.innerWidth / window.innerHeight;
    camera.updateProjectionMatrix();
    renderer.setSize(window.innerWidth, window.innerHeight);
}

function animate() {
    requestAnimationFrame(animate);
    // scene.rotation.y += 0.02;
    render();
}

function render() {
    renderer.render(scene, camera);
}

window.addEventListener('load', () => {
    init();
    animate();
});
