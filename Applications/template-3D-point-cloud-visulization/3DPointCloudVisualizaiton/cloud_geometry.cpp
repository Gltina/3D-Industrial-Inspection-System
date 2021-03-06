#include "cloud_geometry.h"

point_3d::point_3d(const point_3d & p)
{
    this->set_xyz(p.x, p.y, p.z);
    this->set_nxyz(p.nx, p.ny, p.nz);
    this->set_rgb(p.r, p.g, p.b);
}

point_3d::point_3d()
    :x(0), y(0), z(0),
    nx(0), ny(0), nz(0),
    r(0), g(0), b(0)
{
}

point_3d::point_3d(float x, float y, float z)
{
    this->set_xyz(x, y, z);
    this->set_nxyz(0, 0, 0);
    this->set_rgb(0, 0, 0);
}

void point_3d::set_xyz(float x, float y, float z)
{
    this->x = x;
    this->y = y;
    this->z = z;
}

void point_3d::set_nxyz(float nx, float ny, float nz)
{
    this->nx = nx;
    this->ny = ny;
    this->nz = nz;
}

void point_3d::set_rgb(float r, float g, float b)
{
    this->r = r;
    this->g = g;
    this->b = b;
}

point_3d & point_3d::operator=(const point_3d & p)
{
    if (this != &p)
    {
        this->set_xyz(p.x, p.y, p.z);
        this->set_nxyz(p.nx, p.ny, p.nz);
        this->set_rgb(p.r, p.g, p.b);
    }
    return *this;
}

point_3d point_3d::operator+(const point_3d & p)
{
    point_3d tp;

    tp.set_xyz(this->x + p.x, this->y + p.y, this->z + p.z);

    return tp;
}

point_3d point_3d::operator/(const float num)
{
    point_3d tp;

    tp.set_xyz(this->x / num, this->y / num, this->z / num);

    return tp;
}

std::ostream & operator << (std::ostream & os, const point_3d & p)
{
    std::cout
        << "(x,y,z,nx,ny,nz,r,g,b)="
        << p.x << " " << p.y << " " << p.z << " "
        << p.nx << " " << p.ny << " " << p.nz << " "
        << p.r << " " << p.g << " " << p.b << " ";
    return os;
}

void points_to_geometry_node(std::vector<point_3d>& points, osg::ref_ptr<osg::Geometry> geometry, float r, float g, float b, float w)
{
    osg::ref_ptr<osg::Vec3Array> coords = new osg::Vec3Array();
    osg::ref_ptr<osg::Vec4Array> colors = new osg::Vec4Array();
    points_to_osg_structure(points, coords, colors, w);

    // vertex
    geometry->setVertexArray(coords.get());

    // color
    geometry->setColorArray(colors.get());
    geometry->setColorBinding(osg::Geometry::BIND_PER_VERTEX);

    // normals
    //osg::ref_ptr<osg::Vec3Array> normals = new osg::Vec3Array;
    //normals->push_back(osg::Vec3(1.0f, 0.0f, 0.0f));
    //geometry->setNormalArray(normals);
    //geometry->setNormalBinding(osg::Geometry::BIND_OVERALL);

    //geometry->getOrCreateStateSet()->setMode(GL_BLEND,osg::StateAttribute::ON);
    //geometry->getOrCreateStateSet()->setMode(GL_DEPTH_TEST,osg::StateAttribute::ON);
    geometry->getOrCreateStateSet()->setMode(GL_LIGHTING, osg::StateAttribute::OFF | osg::StateAttribute::OVERRIDE);
}

void points_to_osg_structure(std::vector<point_3d>& points, osg::ref_ptr<osg::Vec3Array> coords, osg::ref_ptr<osg::Vec4Array> colors, float w)
{
    for (size_t i = 0; i < points.size(); i++)
    {
        coords->push_back(osg::Vec3(points[i].x, points[i].y, points[i].z));
        colors->push_back(osg::Vec4(points[i].r, points[i].g, points[i].b, w));
    }
}
