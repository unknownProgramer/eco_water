<%--
  Created by IntelliJ IDEA.
  User: smhrd
  Date: 2022-09-27
  Time: 오후 5:48
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="src.model.DamDataDTO" %>
<%@ page import="src.model.DamDataDAO" %>
<%@ page import="src.model.DamStatusDAO" %>
<%@ page import="src.model.DamStatusDTO" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8"/>
    <meta name="viewport"
          content="width=device-width, initial-scale=1, shrink-to-fit=no, width=device-width, user-scalable=no, minimum-scale=1.0, maximum-scale=1.0">
    <link rel="apple-touch-icon" sizes="76x76" href="../assets/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../assets/img/water-icon.png">
    <title>
        삼다수 Web
    </title>
    <!--    Fonts and icons     -->
    <link rel="stylesheet" type="text/css"
          href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700"/>
    <!-- Nucleo Icons -->
    <link href="../assets/css/nucleo-icons.css" rel="stylesheet"/>
    <link href="../assets/css/nucleo-svg.css" rel="stylesheet"/>
    <!-- Font Awesome Icons -->
    <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
    <!-- Material Icons -->
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
    <!-- CSS Files -->
    <link id="pagestyle" href="../assets/css/material-dashboard.css?v=3.0.2" rel="stylesheet"/>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script src="http://dreamplan7.cafe24.com/canvas2/js/three.js"></script>
    <script src="http://dreamplan7.cafe24.com/canvas2/js/OrbitControls.js"></script>
    <script src="http://dreamplan7.cafe24.com/canvas2/js/ColladaLoader.js"></script>
    <script src="http://dreamplan7.cafe24.com/canvas2/js/Sky.js"></script>
    <script src="http://dreamplan7.cafe24.com/canvas2/js/Water.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/dat-gui/0.7.9/dat.gui.js"
            integrity="sha512-Mcz+Mt8k23j06ycA5EJGfyXbtzB6xqEoJxjGftQQoed/zQzem9Lt21LRymjlcm+NUsbF0LOHgfdN8LO8GtKDOw=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.2/css/bootstrap.min.css"
          integrity="sha384-Smlep5jCw/wG7hdkwQ/Z5nLIefveQRIY9nfy6xoR1uRYBtpZgI6339F5dgvm/e9B" crossorigin="anonymous">

    <style>
        .progress {
            position: relative;
            /*left:50.5%;*/

            margin-bottom: 20px;

            top: 40%;
            width: 120px;
            height: 500px;
            opacity: 0.8;
            filter: alpha(opacity=70);

        }

        .progress-bar {
            position: absolute;
            top: 5%;
            bottom: 5%;
            width: 80%;
            height: 90%;
        }

        canvas {

            width: 100%;
            height: 100%

        }

    </style>
</head>

<body class="g-sidenav-show  bg-gray-200">
<%
    DamDataDTO dto = new DamDataDTO();
    DamDataDAO dao = new DamDataDAO();

    dto = dao.getDamDataDTO();

    String height = dto.getD_height();
    String length = dto.getD_length();
    String altitude = dto.getD_altitude();
    String volume = dto.getD_volume();
    String darea = dto.getD_area();
    String suparea = dto.getD_supArea();
    String area = dto.getD_area();
    String fwl = dto.getD_FWL();
    String nwl = dto.getD_NWL();
    String lwl = dto.getD_LWL();
    String maltitude = dto.getD_mAltitude();
    String lowlevelwater = dto.getD_lowLevelWater();
    String tsuparea = dto.getD_tSupArea();
    String valvol = dto.getD_valVol();

    DamStatusDTO dto2 = new DamStatusDTO();
    DamStatusDAO dao2 = new DamStatusDAO();
    dto2 = dao2.getDamStatusDTO();
    ArrayList<DamStatusDTO> list = new ArrayList<DamStatusDTO>();
    DamStatusDTO dto3 = new DamStatusDTO();
    DamStatusDAO dao3 = new DamStatusDAO();
    list = dao3.getList();

    String s_time = dto2.getS_time();
    String s_lowlevelwater = dto2.getS_lowLevelWater();
    String s_waterstorage = dto2.getS_waterStorage();
    String s_pow = dto2.getS_POW();
    String s_inflow = dto2.getS_inflow();
    String s_outflow = dto2.getS_tOutflow();
    float data1 = 0;
    float data2 = 0;
    float data3 = 0;
    String data4 = "";
    if (list.size() > 0) {
        data1 = Float.parseFloat(list.get(0).getS_waterStorage());
        data2 = Float.parseFloat(list.get(1).getS_waterStorage());
        data3 = Math.abs(data1 - data2);
        data4 = String.format("%.4f", data3);
    }


%>
<aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark"
       id="sidenav-main">
    <div class="sidenav-header">
        <i class="fas fa-times p-3 cursor-pointer text-white opacity-5 position-absolute end-0 top-0 d-none d-xl-none"
           aria-hidden="true" id="iconSidenav"></i>
        <a class="navbar-brand m-0" href="#" target="_blank">
            <img src="../assets/img/water-icon.png" class="navbar-brand-img h-100" alt="main_logo">
            <span class="ms-1 font-weight-bold text-white">메뉴</span>
        </a>
    </div>
    <hr class="horizontal light mt-0 mb-2">
    <div class="collapse navbar-collapse  w-auto " id="sidenav-collapse-main">
        <ul class="navbar-nav">
            <li class="nav-item">
                <a class="nav-link text-white active bg-gradient-info" href="dashboard.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">opacity</i>
                    </div>
                    <span class="nav-link-text ms-1">메인</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white " href="../pages/tables.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">opacity</i>
                    </div>
                    <span class="nav-link-text ms-1">저수지역정보예측수심</span>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white " href="../pages/billing.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">opacity</i>
                    </div>
                    <span class="nav-link-text ms-1">저수지역정보예측수심2</span>
                </a>
            </li>
            <li class="nav-item mt-3">
                <h6 class="ps-4 ms-2 text-uppercase text-xs text-white font-weight-bolder opacity-8">계정 관리</h6>
            </li>
            <li class="nav-item">
                <a class="nav-link text-white " href="../pages/sign-in.jsp">
                    <div class="text-white text-center me-2 d-flex align-items-center justify-content-center">
                        <i class="material-icons opacity-10">login</i>
                    </div>
                    <span class="nav-link-text ms-1">Sign In</span>
                </a>
            </li>

        </ul>
    </div>
    <div class="sidenav-footer position-absolute w-100 bottom-0 ">
        <div class="mx-3">
            <a class="btn bg-gradient-info mt-4 w-100" href="#" type="button">닫기</a>
        </div>
    </div>
</aside>
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">

    <!-- Navbar -->
    <nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur"
         navbar-scroll="true">
        <div class="container-fluid py-1 px-3">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb bg-transparent mb-0 pb-0 pt-1 px-0 me-sm-6 me-5">
                    <li class="breadcrumb-item text-sm"><a class="opacity-5 text-dark" href="javascript:(0);">Pages</a>
                    </li>
                    <li class="breadcrumb-item text-sm text-dark active" aria-current="page">메인</li>
                </ol>
                <h6 class="font-weight-bolder mb-0">메인화면</h6>
            </nav>
            <div class="collapse navbar-collapse mt-sm-0 mt-2 me-md-0 me-sm-4" id="navbar">
                <div class="ms-md-auto pe-md-3 d-flex align-items-center">
                    <div class="input-group input-group-outline">
                        <label class="form-label">검색</label>
                        <input type="text" class="form-control">
                    </div>
                </div>
                <ul class="navbar-nav  justify-content-end">
                    <li class="nav-item d-flex align-items-center">
                        <a href="javascript:(0);" class="nav-link text-body font-weight-bold px-0">
                            <i class="fa fa-user me-sm-1"></i>
                            <span class="d-sm-inline d-none">로그인</span>
                        </a>
                    </li>
                    <li class="nav-item d-xl-none ps-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0" id="iconNavbarSidenav">
                            <div class="sidenav-toggler-inner">
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                                <i class="sidenav-toggler-line"></i>
                            </div>
                        </a>
                    </li>
                    <li class="nav-item px-3 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0">
                            <i class="fa fa-cog fixed-plugin-button-nav cursor-pointer"></i>
                        </a>
                    </li>
                    <li class="nav-item dropdown pe-2 d-flex align-items-center">
                        <a href="javascript:;" class="nav-link text-body p-0" id="dropdownMenuButton"
                           data-bs-toggle="dropdown" aria-expanded="false">
                            <i class="fa fa-bell cursor-pointer"></i>
                        </a>
                        <ul class="dropdown-menu  dropdown-menu-end  px-2 py-3 me-sm-n4"
                            aria-labelledby="dropdownMenuButton">
                            <li class="mb-2">
                                <a class="dropdown-item border-radius-md" href="javascript:;">
                                    <div class="d-flex py-1">
                                        <div class="my-auto">
                                            <img src="../assets/img/team-2.jpg" class="avatar avatar-sm  me-3 ">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="text-sm font-weight-normal mb-1">
                                                <span class="font-weight-bold">New message</span> from Laur
                                            </h6>
                                            <p class="text-xs text-secondary mb-0">
                                                <i class="fa fa-clock me-1"></i>
                                                13 minutes ago
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li class="mb-2">
                                <a class="dropdown-item border-radius-md" href="javascript:;">
                                    <div class="d-flex py-1">
                                        <div class="my-auto">
                                            <img src="../assets/img/small-logos/logo-spotify.svg"
                                                 class="avatar avatar-sm bg-gradient-dark  me-3 ">
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="text-sm font-weight-normal mb-1">
                                                <span class="font-weight-bold">New album</span> by Travis Scott
                                            </h6>
                                            <p class="text-xs text-secondary mb-0">
                                                <i class="fa fa-clock me-1"></i>
                                                1 day
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                            <li>
                                <a class="dropdown-item border-radius-md" href="javascript:;">
                                    <div class="d-flex py-1">
                                        <div class="avatar avatar-sm bg-gradient-secondary  me-3  my-auto">
                                            <svg width="12px" height="12px" viewBox="0 0 43 36" version="1.1"
                                                 xmlns="http://www.w3.org/2000/svg"
                                                 xmlns:xlink="http://www.w3.org/1999/xlink">
                                                <title>credit-card</title>
                                                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                                                    <g transform="translate(-2169.000000, -745.000000)" fill="#FFFFFF"
                                                       fill-rule="nonzero">
                                                        <g transform="translate(1716.000000, 291.000000)">
                                                            <g transform="translate(453.000000, 454.000000)">
                                                                <path class="color-background"
                                                                      d="M43,10.7482083 L43,3.58333333 C43,1.60354167 41.3964583,0 39.4166667,0 L3.58333333,0 C1.60354167,0 0,1.60354167 0,3.58333333 L0,10.7482083 L43,10.7482083 Z"
                                                                      opacity="0.593633743"></path>
                                                                <path class="color-background"
                                                                      d="M0,16.125 L0,32.25 C0,34.2297917 1.60354167,35.8333333 3.58333333,35.8333333 L39.4166667,35.8333333 C41.3964583,35.8333333 43,34.2297917 43,32.25 L43,16.125 L0,16.125 Z M19.7083333,26.875 L7.16666667,26.875 L7.16666667,23.2916667 L19.7083333,23.2916667 L19.7083333,26.875 Z M35.8333333,26.875 L28.6666667,26.875 L28.6666667,23.2916667 L35.8333333,23.2916667 L35.8333333,26.875 Z"></path>
                                                            </g>
                                                        </g>
                                                    </g>
                                                </g>
                                            </svg>
                                        </div>
                                        <div class="d-flex flex-column justify-content-center">
                                            <h6 class="text-sm font-weight-normal mb-1">
                                                Payment successfully completed
                                            </h6>
                                            <p class="text-xs text-secondary mb-0">
                                                <i class="fa fa-clock me-1"></i>
                                                2 days
                                            </p>
                                        </div>
                                    </div>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- End Navbar -->

    <div class="container-fluid px-2 px-md-4">
        <div class="page-header min-height-400 border-radius-xl mt-4"
             style="background-image: url('http://ojsfile.ohmynews.com/STD_IMG_FILE/2022/0617/IE003007580_STD.jpeg');">
            <span class="mask opacity-6"></span>
        </div>

        <div class="card card-body mx-3 mx-md-4 mt-n6">

            <div class="row gx-4 mb-2">


                <div class="col-auto my-auto">

                </div>

                <div id="gview">

                </div>


                <!-- 담수 3D모델 위치 조정하는 canvas-->
                <canvas id="canvas">

                </canvas>


                <div class="progress">
                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-info" role="progressbar"
                         style=" " aria-valuenow="50" aria-valuemin="0" aria-valuemax="100">
                        현재수위(EL.m)<br>
                        <%=s_lowlevelwater%>
                    </div>
                </div>


                <div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">


                    <div class="card">
                        <div class="card-header p-3 pt-2">
                            <div class="icon icon-lg icon-shape bg-gradient-info shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                                <i class="material-icons opacity-10">water</i>
                            </div>
                            <div class="text-end pt-1">
                                <p class="text-sm mb-0 text-capitalize"><h4>현재 저수량(백만m³)</h4></p>
                                <h4 class="mb-0"><%=s_waterstorage%>
                                </h4>
                            </div>
                        </div>
                        <hr class="dark horizontal my-0">
                        <div class="card-footer p-3">
                            <p class="mb-0">어제에 비해 <span class="text-success text-sm font-weight-bolder"><%
                                if ((data1 - data2) > 0) {
                            %><%=data4%></span> 상승<%
                            } else {%><%=data4%></span> 하락

                            <%}%>
                            </p>
                        </div>
                    </div>


                    <div class="nav-wrapper position-relative end-0">

                        <script type="importmap">
			{
				"imports": {
					"three": "../build/three.module.js",
					"three/addons/": "./jsm/"
				}
			}








                        </script>

                        <script type="module">

                            import * as THREE from 'three';

                            import {GUI} from 'three/addons/libs/lil-gui.module.min.js';
                            import {OrbitControls} from 'three/addons/controls/OrbitControls.js';
                            import {Water} from 'three/addons/objects/Water2.js';

                            let scene, camera, clock, renderer, water;


                            // 담수 색상 및 높이 디폴트

                            let params = {
                                '담수 색상': 0x010101,
                                '담수 높이': 30 // max : 50
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
                                camera.position.set(60, 100, 0);
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
                                const height = loader.load('../static/pd_depth_black11.jpg');
                                const texture = loader.load('../static/pd_depth_color.jpg');
                                height.warpS = height.wrapT = THREE.RepeatWrapping;

                                // 지면 init
                                const geometry = new THREE.PlaneGeometry(256, 256, 64, 64) // segments 가 높을수록 더 세밀한 오브젝트 생성이 가능

                                // 저수지 수심 init ( wireframe : 격자표현 )
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
                                    textureHeight: 128,
                                });

                                water.position.y = params["담수 높이"];
                                water.rotation.x = Math.PI * -0.5;
                                scene.add(water);

                                ///////////////////
                                //      CUBE     //
                                ///////////////////

                                const cubeTextureLoader = new THREE.CubeTextureLoader();
                                cubeTextureLoader.setPath('textures/cube/skyboxsun25deg/');

                                const cubeTexture = cubeTextureLoader.load([
                                    'px.jpg', 'nx.jpg',
                                    'py.jpg', 'ny.jpg',
                                    'pz.jpg', 'nz.jpg'
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


                                // RENDERER 아래에 저번 코드대로
                                // const renderer = new THREE.WebGLRenderer({canvas});
                                const canvas = document.querySelector('#canvas');

                                renderer = new THREE.WebGLRenderer({canvas});
                                renderer.setSize(window.innerWidth, window.innerHeight);
                                renderer.setPixelRatio(window.devicePixelRatio);
                                // document.body.appendChild( renderer.domElement );
                                // const renderer = new THREE.WebGLRenderer({antialias: true, preserveDrawingBuffer: true});

                                // renderer.setSize(window.innerWidth, window.innerHeight);
                                renderer.setSize(700, 500);
                                // document.body.appendChild(renderer.domElement);

                                renderer.shadowMap.enabled = true;
                                renderer.shadowMap.type = THREE.PCFShadowMap;


                                /////////////////
                                //     GUI     //
                                /////////////////

                                // const gui = new GUI();
                                //
                                // gui.addColor(params, '담수 색상').onChange(function (value) {
                                //
                                //     water.material.uniforms['color'].value.set(value);
                                //
                                // });
                                // gui.add(params, '담수 높이', 25, 50, 0.5).onChange(function (value) {
                                //     water.position.y = value;
                                // });
                                //
                                // gui.open();

                                //////////////////////
                                //     CONTROLS     //
                                //////////////////////

                                const controls = new OrbitControls(camera, renderer.domElement);
                                controls.minDistance = 50;
                                controls.maxDistance = 500;

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

                        </script>


                    </div>
                </div>
            </div>

            <div class="row">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                    <div class="bg-gradient-light shadow-card border-radius-lg pt-4 pb-3">
                        <h6 class="text-white text-capitalize ps-3">설명</h6>
                    </div>
                </div>

            </div>

            <div class="row">


            </div>

        </div>
    </div>
    </div>
    </div>


    <div class="row mt-4">
        <div class="col-lg-4 col-md-6 mt-4 mb-4">
            <div class="card z-index-2 ">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                    <div class="bg-gradient-info shadow-primary border-radius-lg py-3 pe-1">
                        <div class="chart">
                            <canvas id="chart-bars" class="chart-canvas" height="170"></canvas>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <h6 class="mb-0 ">요일별 수위 </h6>
                    <p class="text-sm ">현재 수질정보</p>
                    <hr class="dark horizontal">
                    <div class="d-flex ">
                        <i class="material-icons text-sm my-auto me-1">schedule</i>
                        <p class="mb-0 text-sm">정보 </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 col-md-6 mt-4 mb-4">
            <div class="card z-index-2  ">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                    <div class="bg-gradient-info shadow-success border-radius-lg py-3 pe-1">
                        <div class="chart">
                            <canvas id="chart-line-tasks" class="chart-canvas" height="170"></canvas>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <h6 class="mb-0 "> 저수량 </h6>
                    <p class="text-sm "> 현재 물정보 </p>
                    <hr class="dark horizontal">
                    <div class="d-flex ">
                        <i class="material-icons text-sm my-auto me-1">schedule</i>
                        <p class="mb-0 text-sm"> 정보 </p>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-4 mt-4 mb-3">
            <div class="card z-index-2 ">
                <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
                    <div class="bg-gradient-dark shadow-dark border-radius-lg py-3 pe-1">
                        <div class="chart">
                            <canvas id="chart-line" class="chart-canvas" height="170"></canvas>
                        </div>
                    </div>
                </div>
                <div class="card-body">
                    <h6 class="mb-0 ">3번 정보</h6>
                    <p class="text-sm ">정보</p>
                    <hr class="dark horizontal">
                    <div class="d-flex ">
                        <i class="material-icons text-sm my-auto me-1">schedule</i>
                        <p class="mb-0 text-sm">정보 기입</p>
                    </div>
                </div>
            </div>
        </div>
    </div>


    <footer class="footer py-4  ">
        <div class="container-fluid">
            <div class="row align-items-center justify-content-lg-between">
                <div class="col-lg-6 mb-lg-0 mb-4">
                    <div class="copyright text-center text-sm text-muted text-lg-start">
                        ©
                        <script>
                            document.write(new Date().getFullYear())
                        </script>
                        Project made by <strong>김강훈</strong>, 최낙현, 황인성, 최석재, 정세빈
                    </div>
                </div>
                <div class="col-lg-6">
                    <ul class="nav nav-footer justify-content-center justify-content-lg-end">
                        <li class="nav-item">
                            <a href="#" class="nav-link text-muted" target="_blank">만든사람들</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link text-muted" target="_blank">About Us</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link text-muted" target="_blank">홈페이지</a>
                        </li>
                        <li class="nav-item">
                            <a href="#" class="nav-link pe-0 text-muted" target="_blank">고객지원</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>

</main>

<div class="fixed-plugin">
    <a class="fixed-plugin-button text-dark position-fixed px-3 py-2">
        <i class="material-icons py-2">settings</i>
    </a>


    <div class="card shadow-lg">
        <div class="card-header pb-0 pt-3">
            <div class="float-start">
                <h5 class="mt-3 mb-0">Material UI Configurator</h5>
                <p>See our dashboard options.</p>
            </div>
            <div class="float-end mt-4">
                <button class="btn btn-link text-dark p-0 fixed-plugin-close-button">
                    <i class="material-icons">clear</i>
                </button>
            </div>
            <!-- End Toggle Button -->
        </div>
        <hr class="horizontal dark my-1">
        <div class="card-body pt-sm-3 pt-0">
            <!-- Sidebar Backgrounds -->
            <div>
                <h6 class="mb-0">Sidebar Colors</h6>
            </div>
            <a href="javascript:void(0)" class="switch-trigger background-color">
                <div class="badge-colors my-2 text-start">
                    <span class="badge filter bg-gradient-primary active" data-color="primary"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-dark" data-color="dark" onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-info" data-color="info" onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-success" data-color="success"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-warning" data-color="warning"
                          onclick="sidebarColor(this)"></span>
                    <span class="badge filter bg-gradient-danger" data-color="danger"
                          onclick="sidebarColor(this)"></span>
                </div>
            </a>
            <!-- Sidenav Type -->
            <div class="mt-3">
                <h6 class="mb-0">Sidenav Type</h6>
                <p class="text-sm">Choose between 2 different sidenav types.</p>
            </div>
            <div class="d-flex">
                <button class="btn bg-gradient-dark px-3 mb-2 active" data-class="bg-gradient-dark"
                        onclick="sidebarType(this)">Dark
                </button>
                <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-transparent"
                        onclick="sidebarType(this)">Transparent
                </button>
                <button class="btn bg-gradient-dark px-3 mb-2 ms-2" data-class="bg-white" onclick="sidebarType(this)">
                    White
                </button>
            </div>
            <p class="text-sm d-xl-none d-block mt-2">You can change the sidenav type just on desktop view.</p>
            <!-- Navbar Fixed -->
            <div class="mt-3 d-flex">
                <h6 class="mb-0">Navbar Fixed</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                    <input class="form-check-input mt-1 ms-auto" type="checkbox" id="navbarFixed"
                           onclick="navbarFixed(this)">
                </div>
            </div>
            <hr class="horizontal dark my-3">
            <div class="mt-2 d-flex">
                <h6 class="mb-0">Light / Dark</h6>
                <div class="form-check form-switch ps-0 ms-auto my-auto">
                    <input class="form-check-input mt-1 ms-auto" type="checkbox" id="dark-version"
                           onclick="darkMode(this)">
                </div>
            </div>
            <hr class="horizontal dark my-sm-4">
            <a class="btn bg-gradient-info w-100" href="#">Free Download</a>
            <a class="btn btn-outline-dark w-100" href="#">View documentation</a>
            <div class="w-100 text-center">
                <a class="github-button" href="#" data-icon="octicon-star" data-size="large" data-show-count="true"
                   aria-label="Star creativetimofficial/material-dashboard on GitHub">Star</a>
                <h6 class="mt-3">Thank you for sharing!</h6>
                <a href="#" class="btn btn-dark mb-0 me-2" target="_blank">
                    <i class="fab fa-twitter me-1" aria-hidden="true"></i> Tweet
                </a>
                <a href="#" class="btn btn-dark mb-0 me-2" target="_blank">
                    <i class="fab fa-facebook-square me-1" aria-hidden="true"></i> Share
                </a>
            </div>
        </div>
    </div>
</div>

<!--   Core JS Files   -->
<script src="../assets/js/core/popper.min.js"></script>
<script src="../assets/js/core/bootstrap.min.js"></script>
<script src="../assets/js/plugins/perfect-scrollbar.min.js"></script>
<script src="../assets/js/plugins/smooth-scrollbar.min.js"></script>
<script src="../assets/js/plugins/chartjs.min.js"></script>
<script>
    var ctx = document.getElementById("chart-bars").getContext("2d");

    new Chart(ctx, {
        type: "bar",
        data: {
            labels: ["월", "화", "수", "목", "금", "토", "일", "추가", "추가"],
            datasets: [{
                label: "수량 ",
                tension: 0.4,
                borderWidth: 0,
                borderRadius: 4,
                borderSkipped: false,
                backgroundColor: "rgba(255, 255, 255, .8)",
                data: [50, 20, 10, 22, 50, 10, 40],
                maxBarThickness: 8
            },],
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                }
            },
            interaction: {
                intersect: false,
                mode: 'index',
            },
            scales: {
                y: {
                    grid: {
                        drawBorder: false,
                        display: true,
                        drawOnChartArea: true,
                        drawTicks: false,
                        borderDash: [5, 5],
                        color: 'rgba(255, 255, 255, .2)'
                    },
                    ticks: {
                        suggestedMin: 0,
                        suggestedMax: 500,
                        beginAtZero: true,
                        padding: 10,
                        font: {
                            size: 14,
                            weight: 300,
                            family: "Roboto",
                            style: 'normal',
                            lineHeight: 2
                        },
                        color: "#fff"
                    },
                },
                x: {
                    grid: {
                        drawBorder: false,
                        display: true,
                        drawOnChartArea: true,
                        drawTicks: false,
                        borderDash: [5, 5],
                        borderWidth: 10,
                        color: 'rgba(255, 255, 255, .2)'
                    },
                    ticks: {
                        display: true,
                        color: '#f8f9fa',
                        padding: 10,
                        font: {
                            size: 14,
                            weight: 300,
                            family: "Roboto",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
            },
        },
    });


    var ctx2 = document.getElementById("chart-line").getContext("2d");

    new Chart(ctx2, {
        type: "line",
        data: {
            labels: ["Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"],
            datasets: [{
                label: "수위",
                tension: 0,
                borderWidth: 0,
                pointRadius: 5,
                pointBackgroundColor: "rgba(255, 255, 255, .8)",
                pointBorderColor: "transparent",
                borderColor: "rgba(255, 255, 255, .8)",
                borderColor: "rgba(255, 255, 255, .8)",
                borderWidth: 4,
                backgroundColor: "transparent",
                fill: true,
                data: [50, 40, 300, 320, 500, 350, 200, 230, 500],
                maxBarThickness: 6

            }],
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                }
            },
            interaction: {
                intersect: false,
                mode: 'index',
            },
            scales: {
                y: {
                    grid: {
                        drawBorder: false,
                        display: true,
                        drawOnChartArea: true,
                        drawTicks: false,
                        borderDash: [5, 5],
                        color: 'rgba(255, 255, 255, .2)'
                    },
                    ticks: {
                        display: true,
                        color: '#f8f9fa',
                        padding: 10,
                        font: {
                            size: 14,
                            weight: 300,
                            family: "Roboto",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
                x: {
                    grid: {
                        drawBorder: false,
                        display: false,
                        drawOnChartArea: false,
                        drawTicks: false,
                        borderDash: [5, 5]
                    },
                    ticks: {
                        display: true,
                        color: '#f8f9fa',
                        padding: 10,
                        font: {
                            size: 14,
                            weight: 300,
                            family: "Roboto",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
            },
        },
    });

    var ctx3 = document.getElementById("chart-line-tasks").getContext("2d");

    new Chart(ctx3, {
        type: "line",
        data: {
            labels: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
            datasets: [{
                label: "수위",
                tension: 0,
                borderWidth: 0,
                pointRadius: 5,
                pointBackgroundColor: "rgba(255, 255, 255, .8)",
                pointBorderColor: "transparent",
                borderColor: "rgba(255, 255, 255, .8)",
                borderWidth: 4,
                backgroundColor: "transparent",
                fill: true,
                data: [10, 90, 30, 400, 250, 160, 170, 280, 190, 370, 250, 120],
                maxBarThickness: 6

            }],
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: false,
                }
            },
            interaction: {
                intersect: false,
                mode: 'index',
            },
            scales: {
                y: {
                    grid: {
                        drawBorder: false,
                        display: true,
                        drawOnChartArea: true,
                        drawTicks: false,
                        borderDash: [5, 5],
                        color: 'rgba(255, 255, 255, .2)'
                    },
                    ticks: {
                        display: true,
                        padding: 10,
                        color: '#f8f9fa',
                        font: {
                            size: 14,
                            weight: 300,
                            family: "Roboto",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
                x: {
                    grid: {
                        drawBorder: false,
                        display: false,
                        drawOnChartArea: false,
                        drawTicks: false,
                        borderDash: [5, 5]
                    },
                    ticks: {
                        display: true,
                        color: '#f8f9fa',
                        padding: 10,
                        font: {
                            size: 14,
                            weight: 300,
                            family: "Roboto",
                            style: 'normal',
                            lineHeight: 2
                        },
                    }
                },
            },
        },
    });
</script>

<script>
    var win = navigator.platform.indexOf('Win') > -1;
    if (win && document.querySelector('#sidenav-scrollbar')) {
        var options = {
            damping: '0.5'
        }
        Scrollbar.init(document.querySelector('#sidenav-scrollbar'), options);
    }


</script>
<!-- Github buttons -->
<script async defer src="https://buttons.github.io/buttons.js"></script>
<!-- Control Center for Material Dashboard: parallax effects, scripts for the example pages etc -->
<script src="../assets/js/material-dashboard.min.js?v=3.0.2"></script>
</body>

</html>