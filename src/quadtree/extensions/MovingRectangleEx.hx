package quadtree.extensions;

import quadtree.types.Point;
import quadtree.types.Rectangle;
import quadtree.types.MovingRectangle;

using quadtree.extensions.MovingRectangleEx;


class MovingRectangleEx
{
    public static inline function intersectsWith(hullX: Float, hullY: Float, hullWidth: Float, hullHeight: Float, other: Point): Bool
    {
        return switch other.areaType
        {
            case CollisionAreaType.Point: intersectsWithPoint(hullX, hullY, hullWidth, hullHeight, other);

            case CollisionAreaType.Rectangle: intersectsWithRectangle(hullX, hullY, hullWidth, hullHeight, cast(other, MovingRectangle));

            case CollisionAreaType.MovingRectangle: intersectsWithMovingRectangle(hullX, hullY, hullWidth, hullHeight, cast(other, MovingRectangle));

            case _: throw "Not implemented";
        }
    }


    public static inline function intersectsWithPoint(hullX: Float, hullY: Float, hullWidth: Float, hullHeight: Float, point: Point): Bool
    {
        return point.x > hullX
            && point.y > hullY
            && point.x < hullWidth
            && point.y < hullHeight;
    }


    public static inline function intersectsWithRectangle(hullX: Float, hullY: Float, hullWidth: Float, hullHeight: Float, other: Rectangle): Bool
    {
        return hullX + hullWidth  > other.x
            && hullY + hullHeight > other.y
            && hullX              < other.x + other.width
            && hullY              < other.y + other.height;
    }


    public static inline function intersectsWithMovingRectangle(hullX: Float, hullY: Float, hullWidth: Float, hullHeight: Float, other: MovingRectangle): Bool
    {
        return hullX + hullWidth  > other.hullX()
            && hullY + hullHeight > other.hullY()
            && hullX              < other.hullX() + other.hullWidth()
            && hullY              < other.hullY() + other.hullHeight();
    }


    public static inline function hullX(rect: MovingRectangle): Float
    {
        return Math.min(rect.x, rect.lastX);
    }
    

    public static inline function hullY(rect: MovingRectangle): Float
    {
        return Math.min(rect.y, rect.lastY);
    }
    

    public static inline function hullWidth(rect: MovingRectangle): Float
    {
        return rect.width + Math.abs(rect.x - rect.lastX);
    }
    

    public static inline function hullHeight(rect: MovingRectangle): Float
    {
        return rect.height + Math.abs(rect.y - rect.lastY);
    }
}